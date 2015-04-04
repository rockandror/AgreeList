require 'spec_helper'

describe Comment do
  let(:individual) { create(:individual) }
  let(:statement) { create(:statement) }

  it 'should require individual_id' do
    comment = Comment.create(text: "comment", individual_id: nil, statement: statement)
    expect(comment.valid?).to eq false
  end

  it 'should require statement_id' do
    comment = Comment.create(text: "comment", individual: individual, statement_id: nil)
    expect(comment.valid?).to eq false
  end
end
