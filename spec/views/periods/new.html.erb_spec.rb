require 'spec_helper'

describe "periods/new" do
  before(:each) do
    assign(:period, stub_model(Period,
      :number => 1,
      :code => 1
    ).as_new_record)
  end

  it "renders new period form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", periods_path, "post" do
      assert_select "input#period_number[name=?]", "period[number]"
      assert_select "input#period_code[name=?]", "period[code]"
    end
  end
end
