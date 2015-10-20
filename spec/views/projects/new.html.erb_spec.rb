require 'spec_helper'

describe "projects/new" do
  before(:each) do
    assign(:project, stub_model(Project,
      :name => "",
      :period => "",
      :url => "",
      :summary => "MyText"
    ).as_new_record)
  end

  it "renders new project form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", projects_path, "post" do
      assert_select "input#project_name[name=?]", "project[name]"
      assert_select "input#project_period[name=?]", "project[period]"
      assert_select "input#project_url[name=?]", "project[url]"
      assert_select "textarea#project_summary[name=?]", "project[summary]"
    end
  end
end
