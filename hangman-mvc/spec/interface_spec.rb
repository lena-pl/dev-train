require_relative "../model.rb"
require_relative "../interface.rb"

RSpec.describe Model do
  let(:model) { Model.new("example") }
  let(:ui) { Interface.new(model) }

  describe "#encrypted_target" do

    it "returns a string with underscores" do
      allow(model).to receive(:encrypted_word_array).and_return(["e","x","a","m","p",nil,"e"])
      expect(ui.encrypted_target).to eq "e x a m p _ e"
    end

  end
end
