require 'rails_helper'

RSpec.describe Technology do
  describe 'finders' do
    describe 'react' do
      subject { Technology::DEFINITIONS[:react] }

      it 'returns jobs that include react' do
        job = create(:job, description: 'bla react bla')
        expect(subject.call).to include(job)
      end

      it 'returns jobs that include react.js' do
        job = create(:job, description: 'bla react.js bla')
        expect(subject.call).to include(job)
      end

      it 'returns jobs that include reactjs' do
        job = create(:job, description: 'bla reactjs bla')
        expect(subject.call).to include(job)
      end

      it 'does not return jobs containing reaction' do
        create(:job, description: 'bla reaction bla')
        expect(subject.call).to be_empty
      end

      it 'does not return jobs that only contain react-native' do
        create(:job, description: 'bla react-native bla')
        expect(subject.call).to be_empty
      end

      it 'does not return jobs that only contain react native' do
        create(:job, description: 'bla react native bla')
        expect(subject.call).to be_empty
      end
    end
  end
end
