require 'spec_helper'

describe ProposalsController do

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end
  
  describe "POST 'create'" do
    before(:each) do
      @user = User.generate!
      controller.send(:current_uesr=, @user)
    end
    
    def do_action
      post :create, :proposal => {:title => '[title]', :description => '[description]'}
    end
    
    it "should create a proposal" do
      proc { do_action }.should change(Proposal, :count).by(1)
    end
    
    it "should assign the current_user to the created proposal" do
      do_action
      assigns(:proposal).should == @user
    end
  end

end
