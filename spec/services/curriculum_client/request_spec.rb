require 'rails_helper'

RSpec.describe CurriculumClient::Request do
  let(:url) { CurriculumClient::Connection::CURRICULUM_APP_URL }
  let(:null_error_response_json) { File.new('spec/support/curriculum/responses/key_stage_null_error.json').read }
  let(:other_error_response_json) { File.new('spec/support/curriculum/responses/key_stage_other_error.json').read }

  describe 'request' do
    before do
      stub_a_valid_schema_request
    end

    it 'raises an error if an unexpected or empty client instance is passed' do
      expect { described_class.run(context: :key_stage, query: nil, client: {}) }
        .to raise_error(CurriculumClient::Errors::ConnectionError)
    end

    it 'raises an error for an unparsed query' do
      client = CurriculumClient::Connection.connect

      query = <<~GRAPHQL
        query {}
      GRAPHQL

      expect { described_class.run(context: :key_stage, query: query, client: client) }
        .to raise_error(CurriculumClient::Errors::UnparsedQuery)
    end

    it "raises an error if a connection isn't possible" do
      client = CurriculumClient::Connection.connect

      stub_request(:post, url)
        .to_raise(Errno::ECONNREFUSED)

      query = <<~GRAPHQL
        query {
          keyStages {
            id
            title
            description
          }
        }
      GRAPHQL
      expect { described_class.run(context: :key_stage, query: client.parse(query), client: client) }
        .to raise_error(CurriculumClient::Errors::ConnectionError, /Unable to connect to/)
    end

    it 'raises a 404 for an invalid record' do
      client = CurriculumClient::Connection.connect

      response = JSON.parse(null_error_response_json, object_class: OpenStruct)

      stub_request(:post, url)
        .to_raise(Graphlient::Errors::ExecutionError.new(response))

      query = <<~GRAPHQL
        query {
          keyStage(slug: "nonsense") {
            id
          }
        }
      GRAPHQL

      expect { described_class.run(context: :key_stage, query: client.parse(query), client: client) }
        .to raise_error(CurriculumClient::Errors::RecordNotFound)
    end

    it "doesn't block other execution errors" do
      client = CurriculumClient::Connection.connect

      response = JSON.parse(other_error_response_json, object_class: OpenStruct)

      stub_request(:post, url)
        .to_raise(Graphlient::Errors::ExecutionError.new(response))

      query = <<~GRAPHQL
        query {
          keyStage(slug: "nonsense") {
            id
          }
        }
      GRAPHQL

      expect { described_class.run(context: :key_stage, query: client.parse(query), client: client) }
        .to raise_error(Graphlient::Errors::ExecutionError)
    end
  end
end
