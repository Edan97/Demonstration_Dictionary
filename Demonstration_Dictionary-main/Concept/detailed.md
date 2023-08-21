# Detailed dictionary contents
# Conventions
# Lines beginning "# " are comments
# Other lines are "#<X>" where x means the following:
# C - category T - text definition K - keys D - definition
# S - is set category X - dictionary name Z - dictionary info
# blank line between definitions

#X Microsymposium_Dic
#Z A dictionary for storing information about microsymposia.

#C Microsymposium
#T Information about a particular microsymposium
#S

#D id
#T An identifier for this microsymposium.

#D title
#T The microsymposium title

#D date
#T The date on which the microsymposium is held

#D time
#T The starting time for the microsymposium

#C presentation
#T Category holding information about presentations
#K id

#D id
#T A unique identifier for the presentation

#D title
#T Title of presentation

#D abstract
#T Abstract for presentation


#C talk
#T Information about oral presentations
#K presentation_id

#D presentation_id
#T The unique identifier for the presentation
#N presentation.id

#D speaking_time
#T Scheduled length of presentation

#D question_time
#T Scheduled length of question time for presentation

#D total_time
#T Total scheduled time for presentation, consisting of speaking time and question time


#C author_list
#T A category associating authors with presentations
#K author_id, presentation_id

#D author_id
#T Identifier of the author belonging to the presentation
#N author.id

#D presentation_id
#T Identifier of the presentation that the author is a part of
#N presentation.id

