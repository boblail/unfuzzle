module Unfuzzle
  class Component
    
    include Graft::Model
    
    attribute :id, :type => :integer
    attribute :name
    attribute :project_id, :from => 'project-id', :type => :integer
    attribute :created_at, :from => 'created-at', :type => :time
    attribute :updated_at, :from => 'updated-at', :type => :time
    
    def self.find_by_project_id_and_component_id(project_id, component_id)
      response = Request.get("/projects/#{project_id}/components/#{component_id}")
      new response.body
    end
    
  end
end