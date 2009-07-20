module Unfuzzle

  # = Milestone
  #
  # A representation of an Unfuddle Milestone.  Has the following attributes:
  #
  # [id] Unique identifier for this milestone
  # [name] Name of the milestone
  #
  class Milestone

    include Graft::Model

    attribute :id, :type => :integer
    attribute :project_id, :from => 'project-id', :type => :integer
    attribute :archived, :type => :boolean
    attribute :name, :from => 'title'
    attribute :created_timestamp, :from => 'created-at'
    attribute :updated_timestamp, :from => 'updated-at'
    attribute :due_datestamp, :from => 'due-on'

    # Return a list of all milestones for a given project
    def self.find_all_by_project_id(project_id)
      response = Request.get("/projects/#{project_id}/milestones")
      collection_from(response.body, 'milestones/milestone')
    end

    def self.find_by_project_id_and_milestone_id(project_id, milestone_id)
      response = Request.get("/projects/#{project_id}/milestones/#{milestone_id}")
      new response.body
    end

    # Has this milestone been archived?
    def archived?
      archived == true
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

    def past?
      due_on < Date.today
    end

    # The collection of Tickets associated to this milestone
    def tickets
      Ticket.find_all_by_project_id_and_milestone_id(project_id, id)
    end

  end
end