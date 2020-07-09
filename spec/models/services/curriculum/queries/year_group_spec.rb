require 'spec_helper'

RSpec.describe Curriculum::Queries::YearGroup do
  before do
    stub_a_valid_schema_request
  end

  it 'creates valid queries' do
    expect { described_class.all }.not_to raise_error
    expect { described_class.one('some_id') }.not_to raise_error
  end
end
