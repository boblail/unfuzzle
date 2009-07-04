module Unfuzzle

  # = Ticket
  #
  # Represents a single Unfuddle Ticket - is associated to a project
  # and optionally a project's milestone.  Has the following attributes:
  #
  # [id] The unique identifier for this ticket
  # [number] The ticket's number - this is displayed in the web interface
  # [title] The title of the ticket (short)
  # [description] The full description of the ticket
  # [status] The ticket's status (new / accepted / resolved / closed)
  #
  class Ticket

    include Unfuzzle::Model

    attribute :id
    attribute :project_id
    attribute :milestone_id
    attribute :number
    attribute :title, :from => :summary
    attribute :description
    attribute :due_datestamp, :from => :due_on
    attribute :created_timestamp, :from => :created_at
    attribute :updated_timestamp, :from => :updated_at
    attribute :status

    # Return a list of all tickets for an individual project
    def self.find_all_by_project_id(project_id)
      response = Request.get("/projects/#{project_id}/tickets")
      response.data.map {|data| new(data) }
    end

    # Return a list of all tickets for a given milestone as part of a project
    def self.find_all_by_project_id_and_milestone_id(project_id, milestone_id)
      response = Request.get("/projects/#{project_id}/milestones/#{milestone_id}/tickets")
      response.data.map {|data| new(data) }
    end

    # The DateTime that this milestone was created
    def created_at
      DateTime.parse(created_timestamp)
    end

    # The DateTime that this milestone was last updated
    def updated_at
      DateTime.parse(updated_timestamp)
    end

    # The Date that this milestone is due
    def due_on
      Date.parse(due_datestamp) unless due_datestamp.nil?
    end
   
    def milestone
      Milestone.find_by_project_id_and_milestone_id(project_id, milestone_id)
    end
    
    def update
      resource_path = "/projects/#{project_id}/tickets/#{id}"
      Request.put(resource_path, self.to_xml)
    end

  end
end