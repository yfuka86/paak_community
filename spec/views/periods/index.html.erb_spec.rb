require 'spec_helper'

describe "periods/index" do
  before(:each) do
    assign(:periods, [
      stub_model(Period,
        :number => 1,
        :code => 2
      ),
      stub_model(Period,
        :number => 1,
        :code => 2
      )
    ])
  end

  it "renders a list of periods" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
