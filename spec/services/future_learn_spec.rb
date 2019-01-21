require 'rails_helper'

RSpec.describe FutureLearn, type: :class do
  describe '#courses' do
    let(:future_learn) { FutureLearn.new }

    it 'contains 9 courses' do
      expect(future_learn.courses.count).to eq 5
    end

    it 'contains a title' do
      future_learn.courses.each do |course|
        expect(course[:title]).to be_truthy
      end
    end

    it 'contains a description' do
      future_learn.courses.each do |course|
        expect(course[:description]).to be_truthy
      end
    end

    it 'contains a link' do
      future_learn.courses.each do |course|
        expect(course[:link]).to be_truthy
      end
    end
  end
end
