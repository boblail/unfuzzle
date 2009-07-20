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
    
    include Graft::Model
    
    attribute :id, :type => :integer
    attribute :slug, :from => 'short-name'
    attribute :archived, :type => :boolean
    attribute :name, :from => 'title'
    attribute :description
    attribute :created_timestamp, :from => 'created-at'
    attribute :updated_timestamp, :from => 'updated-at'

    # Return a list of all projects to which the current user has access
    def self.all
      response = Request.get('/projects')
      collection_from(response.body, 'projects/project')
    end
    
    # Find a single project by its slug (short name)
    def self.find_by_slug(slug)
      response = Request.get("/projects/by_short_name/#{slug}")
      new(response.body)
    end

    # Find a single project by its ID
    def self.find_by_id(id)
      response = Request.get("/projects/#{id}")
      new(response.body)
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

    # The collection of Milestones associated to this project
    def milestones
      Milestone.find_all_by_project_id(id)
    end

    # The collection of Tickets associated to this project
    def tickets
      Ticket.find_all_by_project_id(id)
    end

  end
end