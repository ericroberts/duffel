require 'duffel'

describe Duffel do
  subject { Duffel }

  it 'should not raise an error' do
    expect { subject }.to_not raise_error
  end

  describe '.not_an_existing_method' do
    context 'without a matching environment variable' do
      it 'should raise an error if nothing exists in the environment' do
        expect { subject.not_an_existing_method }.to raise_error(KeyError)
      end

      context 'with a fallback passed' do
        it 'should return the fallback' do
          expect(
            subject.another_non_existing_method(:fallback => 'blah')
          ).to eq 'blah'
        end

        it 'should be idempotent' do
          expect(
            subject.another_non_existing_method(:fallback => 'blah')
          ).to eq 'blah'
          expect(
            subject.another_non_existing_method(:fallback => 'blah')
          ).to eq 'blah'
        end

        it 'should allow a different fallback the next time it is called' do
          expect(
            subject.another_non_existing_method(:fallback => 'foo')
          ).to eq 'foo'
        end

        context 'fallback is nil' do
          it 'should return nil' do
            expect(
              subject.yet_another_non_existing_method(:fallback => nil)
            ).to eq nil
          end

          it 'should be idempotent' do
            expect(
              subject.yet_another_non_existing_method(:fallback => nil)
            ).to eq nil
            expect(
              subject.yet_another_non_existing_method(:fallback => nil)
            ).to eq nil
          end

          it 'should allow a different fallback the next time it is called' do
            expect(
              subject.yet_another_non_existing_method(:fallback => 'bar')
            ).to eq 'bar'
          end
        end
      end
    end

    context 'with a matching environment variable' do
      before do
        allow(ENV).to(
          receive(:fetch).
          with('AN_EXISTING_METHOD').
          and_return(response)
        )
      end

      let(:response) { 'response' }

      it 'should return the env variable' do
        expect(subject.an_existing_method).to eq response
      end

      it 'should be idempotent' do
        expect(subject.an_existing_method).to eq response
        expect(subject.an_existing_method).to eq response
      end
    end
  end
end
