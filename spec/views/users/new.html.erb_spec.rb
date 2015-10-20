require 'spec_helper'

describe "users/new" do
  before(:each) do
    assign(:user, stub_model(User,
      :paak_id => "",
      :type => "",
      :project_id => "",
      :name => "",
      :url => "",
      :image_url => "",
      :summary => "MyText"
    ).as_new_record)
  end

  it "renders new user form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", users_path, "post" do
      assert_select "input#user_paak_id[name=?]", "user[paak_id]"
      assert_select "input#user_type[name=?]", "user[type]"
      assert_select "input#user_project_id[name=?]", "user[project_id]"
      assert_select "input#user_name[name=?]", "user[name]"
      assert_select "input#user_url[name=?]", "user[url]"
      assert_select "input#user_image_url[name=?]", "user[image_url]"
      assert_select "textarea#user_summary[name=?]", "user[summary]"
    end
  end
end
