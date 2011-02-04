require 'spec_helper'

describe ProposalsController do
  before(:each) do
    @category = Factory(:category)
  end

  describe "GET 'index'" do
    it "should be successful" do
      get 'index', :category_id => @category.id
      response.should be_success
    end
  end
  
  describe "POST 'create'" do
    before(:each) do
      @user = Factory(:user)
      sign_in @user
    end
    
    def do_action
      post :create, :category_id => @category.id, :proposal => {:title => '[title]', :description => '[description]'}
    end
    
    it "should create a proposal" do
      proc { do_action }.should change(Proposal, :count).by(1)
    end
    
    it "should assign the current_user to the created proposal" do
      do_action
      assigns(:proposal).user.should == @user
    end
  end

end