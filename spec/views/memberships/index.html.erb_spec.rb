require 'spec_helper'

describe "memberships/index" do
  before(:each) do
    assign(:memberships, [
      stub_model(Membership,
        :paak_id => 1,
        :user_id => 2,
        :period_id => 3,
        :name => "Name"
      ),
      stub_model(Membership,
        :paak_id => 1,
        :user_id => 2,
        :period_id => 3,
        :name => "Name"
      )
    ])
  end

  it "renders a list of memberships" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
