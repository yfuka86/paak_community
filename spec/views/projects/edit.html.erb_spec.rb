require 'spec_helper'

describe "projects/edit" do
  before(:each) do
    @project = assign(:project, stub_model(Project,
      :name => "",
      :period => "",
      :url => "",
      :summary => "MyText"
    ))
  end

  it "renders the edit project form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", project_path(@project), "post" do
      assert_select "input#project_name[name=?]", "project[name]"
      assert_select "input#project_period[name=?]", "project[period]"
      assert_select "input#project_url[name=?]", "project[url]"
      assert_select "textarea#project_summary[name=?]", "project[summary]"
    end
  end
end
