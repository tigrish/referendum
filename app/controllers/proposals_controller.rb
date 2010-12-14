class ProposalsController < InheritedResources::Base
  actions :all, :except => [:edit, :update, :destroy]
end
