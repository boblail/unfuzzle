module Unfuzzle
  
  # = Project
  #
  # Represents an Unfuddle project.  Has the following attributes:
  #
  # [id] The unique identifier for this project
  # [slug] The "short name" for this project
  # [name] The name of this project
  # [description] The description for the project
  #
  class Project
    
    include Unfuzzle::Model
    
    attribute :id
    attribute :slug, :from => :short_name
    attribute :archived
    attribute :name, :from => :title
    attribute :description
    attribute :created_timestamp, :from => :created_at
    attribute :updated_timestamp, :from => :updated_at

    # Return a list of all projects to which the current user has access
    def self.all
      response = Request.get('/projects')
      response.parse.map {|data| Project.new(data) }
    end
    
    # Has this project been archived?
    def archived?
      archived == true
    end
    
    # The DateTime that this project was created
    def created_at
      DateTime.parse(created_timestamp)
    end
    
    # The DateTime that this project was last updated
    def updated_at
      DateTime.parse(updated_timestamp)
    end
    
    def milestones
      Milestone.find_all_by_project_id(id)
    end

  end
end