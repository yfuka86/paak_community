require 'spec_helper'

describe "memberships/new" do
  before(:each) do
    assign(:membership, stub_model(Membership,
      :paak_id => 1,
      :user_id => 1,
      :period_id => 1,
      :name => "MyString"
    ).as_new_record)
  end

  it "renders new membership form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", memberships_path, "post" do
      assert_select "input#membership_paak_id[name=?]", "membership[paak_id]"
      assert_select "input#membership_user_id[name=?]", "membership[user_id]"
      assert_select "input#membership_period_id[name=?]", "membership[period_id]"
      assert_select "input#membership_name[name=?]", "membership[name]"
    end
  end
end
