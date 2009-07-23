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

    include Graft::Model

    attribute :id, :type => :integer
    attribute :project_id, :from => 'project-id', :type => :integer
    attribute :milestone_id, :from => 'milestone-id', :type => :integer
    attribute :component_id, :from => 'component-id', :type => :integer
    attribute :priority_id, :from => 'priority', :type => :integer
    attribute :number
    attribute :title, :from => 'summary'
    attribute :description
    attribute :due_on, :from => 'due-on', :type => :date
    attribute :created_at, :from => 'created-at', :type => :time
    attribute :updated_at, :from => 'updated-at', :type => :time
    attribute :severity_id, :from => 'severity-id', :type => :integer
    attribute :status

    # Return a list of all tickets for an individual project
    def self.find_all_by_project_id(project_id)
      response = Request.get("/projects/#{project_id}/tickets")
      collection_from(response.body, 'tickets/ticket')
    end

    # Return a list of all tickets for a given milestone as part of a project
    def self.find_all_by_project_id_and_milestone_id(project_id, milestone_id)
      response = Request.get("/projects/#{project_id}/milestones/#{milestone_id}/tickets")
      collection_from(response.body, 'tickets/ticket')
    end

    def milestone
      Milestone.find_by_project_id_and_milestone_id(project_id, milestone_id)
    end
    
    def severity
      Severity.find_by_project_id_and_severity_id(project_id, severity_id)
    end
    
    def severity_name
      severity.name
    end
    
    def priority
      Priority.new(priority_id)
    end
    
    def priority_name
      priority.name
    end
    
    def component
      Component.find_by_project_id_and_component_id(project_id, component_id)
    end
    
    def component_name
      component.name
    end
    
    def to_hash
      {
        'id'           => id,
        'project_id'   => project_id,
        'milestone_id' => milestone_id,
        'number'       => number,
        'summary'      => title,
        'description'  => description,
        'status'       => status
      }
    end
    
    def update
      resource_path = "/projects/#{project_id}/tickets/#{id}"
      Request.put(resource_path, self.to_xml('ticket'))
    end

  end
end