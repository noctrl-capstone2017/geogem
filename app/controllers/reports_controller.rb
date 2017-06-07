#Author: Taylor Spino
class ReportsController < ApplicationController

def report1

#Right now, the FIRST table only shows events that occured in between the
#session START and END time.

#The SECOND and THIRD tables show ANY duration events and notes, respectively,
#that happened during the session.

#It's moderately useful for debugging, but I can easily change this if we 
#want to.

pdf = Prawn::Document.new
pdf.font "Helvetica"

# Defining the grid (this might not be needed in the long run)
# See http://prawn.majesticseacreature.com/manual.pdf
pdf.define_grid(:columns => 5, :rows => 8, :gutter => 10) 


                      # -------Session Data---------#
session = Session.find(params[:id])
student = Student.find(session.session_student)
teacher = Teacher.find(session.session_teacher)

#each square pressed for the current session of interest
eventsArray = SessionEvent.where(session_id: session.id).to_a

#roster_squaresMap is a map of square objects, the roster squares for the student
#stud_squares is an array of square objects for the student
roster_squares = RosterSquare.where(student_id: student.id)
stud_squares = Array.new

roster_squares.each do |roster_square|
  stud_squares.push(Square.find(roster_square.square_id))
end

#SORT the stud_squares array by square TYPE
#Will sort by duration, then frequency, then interval
stud_squares.sort! { |a,b| a.tracking_type  <=> b.tracking_type}

                      # -------Header Info---------#

pdf.text "Behavior Session Summary", :size => 14, :align => :center

pdf.grid([0,0], [0,1]).bounding_box do
  pdf.text " "
  pdf.text "Student Name: " + student.full_name , :align => :left
  pdf.text "Teacher Name: " + teacher.full_name , :align => :left
end

#Bounding box is confusing, other ideas for multi-column are greatly appreciated
pdf.grid([0,0], [0,4]).bounding_box do 
  pdf.text " "
  pdf.text "Date: #{session.start_time.to_date}", :align => :right
  pdf.text "Time: " + session.start_time.strftime("%I:%M%p") + " - " +
                      session.end_time.strftime("%I:%M%p"), :align => :right
end

                      # -------ENTIRE SUMMARY TABLE---------#

#Let's start doing some actual data rows for our table
entireSummaryRows = Array.new

#Grab student interval time
stud_interval = student.session_interval 

startI = session.start_time

#adds stud_interval minutes to the start time
endI = session.start_time + stud_interval*60

one_time_loop = false
if(TimeDifference.between(session.start_time, 
                            session.end_time).in_minutes < stud_interval)
one_time_loop = true
end

while (endI <= session.end_time || one_time_loop)

singleSummaryRow = Array.new
singleSummaryRow.push(startI.strftime("%I:%M%p") + " - " + endI.strftime("%I:%M%p"))

#in each loop, we need to make a row of data for the specific
#interval we are dealing with (startI, endI)
  stud_squares.each do |bSquare|
    
    
    #FREQUENCY CODE
    if(bSquare.tracking_type == 2)
      
    singleSummaryRow.push(eventsArray.count { |x| x.behavior_square_id == bSquare.id && 
                    (startI <= x.square_press_time &&  x.square_press_time<endI||
                    x.square_press_time <= startI && startI < x.duration_end_time)})
    
    end
    
    
    #INTERVAL CODE
    if(bSquare.tracking_type == 3)
      
      y = eventsArray.count { |x| x.behavior_square_id == bSquare.id && 
                    (startI <= x.square_press_time &&  x.square_press_time<endI||
                    x.square_press_time <= startI && startI < x.duration_end_time)}
                                          
      if(y > 0)
         
         singleSummaryRow.push("X")
      
      else
      
      singleSummaryRow.push(" ")
      
      end
    
    end
    
    
    #DURATION CODE
    if(bSquare.tracking_type == 1)
      
    z = eventsArray.count { |x| x.behavior_square_id == bSquare.id && 
                    (startI <= x.square_press_time &&  x.square_press_time<endI||
                    x.square_press_time <= startI && startI < x.duration_end_time)}
      if(z > 0)
         
         singleSummaryRow.push("D")
      
      else
      
      singleSummaryRow.push(" ")
      
      end
    
    end
    
  end

  entireSummaryRows.push(singleSummaryRow)
  one_time_loop = false
  startI = startI + stud_interval*60
  endI = endI + stud_interval*60
  
end

#squareScreenNames is array of screen names for each type of square pressed in sesh
squareScreenNames = Array.new

stud_squares.each do |v|
squareScreenNames.push(v.screen_name)
end

squareScreenNames.insert(0, "Time")

table = Array.new
table.push(squareScreenNames)

#push the rows onto our Array of arrays
entireSummaryRows.each do |r|
table.push(r)
end

pdf.move_up 20
pdf.text "All Behaviors Exhibited during Session", :style => :bold
pdf.stroke_horizontal_rule
pdf.move_down 10

pdf.table table, :header => true,
  :row_colors => ["d2e3ed", "FFFFFF"], :position => :center
  
                       # -------DURATION NOTES TABLE---------#

#this is all the durations Squares that were pushed during sesh
durSquares = Array.new

stud_squares.each do |h|

if(h.tracking_type == 1)
 durSquares.push(h)  
  
end
end

durationSummaryRows = Array.new 

durSquares.each do |d|
r = Array.new
#find all events with the same duration square pressed
r = eventsArray.find_all { |x| x.behavior_square_id  == d.id }
#sort them by press time
r.sort! { |a,b| a.square_press_time   <=> b.square_press_time}

if(!r.empty?)
durationSummaryRows.push(r)
end

end

#now sort the rows (each row is a collection of events that are of the same square id)
#and sort them by the press time of the start time of the FIRST element of array

durationSummaryRows.sort! { |a,b| a.first.square_press_time   <=> b.first.square_press_time}


durationTableHeader = ["Behaviors", "Start Time", "End Time", "Duration"]

table2 = Array.new {Array.new}
table2.push(durationTableHeader)

durationSummaryRows.each do |collection|
collection.each do |dEvent|
table2.push([Square.find(dEvent.behavior_square_id ).screen_name.to_s, 
              dEvent.square_press_time.strftime("%I:%M%p"),
              dEvent.duration_end_time.strftime("%I:%M%p"),
              TimeDifference.between(dEvent.square_press_time, 
                            dEvent.duration_end_time).in_minutes.to_s + " min"])  
  
end
end


pdf.move_down 50
pdf.text "Duration Behaviors Exhibited during Session", :style => :bold
pdf.stroke_horizontal_rule
pdf.move_down 10
pdf.table table2, :header => true, 
  :column_widths => { 0 => 100, 1 => 75, 2 => 75, 3 => 75, 4=> 75},
  :row_colors => ["d2e3ed", "FFFFFF"], :position => :center
  
                       # -------Notes Table---------#                      

notesTakenMap = SessionNote.where(session_id: session.id)
notesTaken = Array.new

notesTakenMap.each do |m|
notesTaken.push(m)
end

notesTaken.sort!{ |a,b| a.created_at   <=> b.created_at}

notesTable = Array.new {Array.new}
notesTable.push(["Time", "Note"])

notesTaken.each do |noteOb|
noteRow = Array.new
noteRow.push((noteOb.created_at).strftime("%I:%M%p"))
noteRow.push(noteOb.note)
notesTable.push(noteRow)
end

pdf.move_down 50
pdf.text "Notes taken during Session", :style => :bold
pdf.stroke_horizontal_rule
pdf.move_down 10
pdf.table notesTable, :header => true, 
  :column_widths => { 0 => 150, 1 => 300},
  :row_colors => ["d2e3ed", "FFFFFF"], :position => :center               
                      
                      
                      
                      
                       # -------SESSION KEY---------#
table3 = Array.new {Array.new}
rows3 = Array.new{Array.new}

stud_squares.each do |s|
keyRow = Array.new
keyRow.push(s.screen_name.to_s)
keyRow.push(" = ")
keyRow.push(s.description.to_s)

if(s.tracking_type == 1)
  keyRow.push("Duration")
else 
  if(s.tracking_type == 2)
  keyRow.push("Frequency")
  else 
    if(s.tracking_type == 3)
      keyRow.push("Interval")
    end
  end
end

rows3.push(keyRow)
end

rows3.each do |r2|
table3.push(r2)  
end

#will get error if there the rows3 array is empty because that
# means we have nothing to display (since this table doesnt have a header)
if(rows3.count > 0)
pdf.move_down 50
pdf.text "Session Key", :style => :bold
pdf.stroke_horizontal_rule
pdf.move_down 10
pdf.table table3, :header => true, :cell_style => { :border_color => "FFFFFF" },
 :column_widths => { 0 => 40, 1 => 25, 2 => 200, 3 => 100},:position => :left
end




# Change by Nate V. - Switched from file download to page display of pdf file
# To revert back to downloading a file, remove "disposition: 'inline'"
send_data pdf.render, :filename => "Report1.pdf", :type =>
 "application/pdf", disposition: 'inline'

end

def csv1
    # Grabs the latest session's collection of Session Events
    session = Session.last
    eventsOccurred = SessionEvent.where(session_id: session.id)
    


    # Array used to find a square's square type
    square_types = ["null", "Duration", "Frequency", "Interval"]
    
    # Uses the csv renderer to create a csv string to be updated with the 
    # requisite values
    csv_string = CSV.generate do |csv|
        csv << %w(num square square_type press_time end_time)
        eventsOccurred.each do |item|
            # Specify the square for each given event
            eventSquare = Square.where(id: item.behavior_square_id)
            # Find the given square's screen name and square type
            scrnName = eventSquare.screen_name
            squareType = square_types[eventSquare.tracking_type]
            # Update the csv_string
            csv << [item.id,  scrnName, squareType, 
                item.square_press_time, item.duration_end_time]
        end
    end
    # Renders the csv file
    respond_to do |format|
        format.csv { render :csv => csv_string, :filename => "Report1.csv" }
    end
end


end