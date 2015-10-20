require 'spec_helper'

describe "periods/edit" do
  before(:each) do
    @period = assign(:period, stub_model(Period,
      :number => 1,
      :code => 1
    ))
  end

  it "renders the edit period form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", period_path(@period), "post" do
      assert_select "input#period_number[name=?]", "period[number]"
      assert_select "input#period_code[name=?]", "period[code]"
    end
  end
end
