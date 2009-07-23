module Unfuzzle
  class Severity
    
    include Graft::Model
    
    attribute :id, :type => :integer
    attribute :name
    attribute :project_id, :from => 'project-id', :type => :integer
    attribute :created_at, :from => 'created-at', :type => :time
    attribute :updated_at, :from => 'updated-at', :type => :time
    
    def self.find_by_project_id_and_severity_id(project_id, severity_id)
      response = Request.get("/projects/#{project_id}/severities/#{severity_id}")
      new response.body
    end
    
  end
end