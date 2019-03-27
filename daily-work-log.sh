# Ding and put badge icon on terminal
tput bel

# Present alert
osascript -e 'tell app (path to frontmost application as text) to display dialog "Time for your daily journal entry" buttons {"OK"} with title "Daily Journal"'

clear

echo "\nDaily Journal Entry"
date "+DATE: %Y-%m-%d, %H:%M:%S%n"

user_first_name='Dan'
# List of questions
first_question="What did you work on today?"
second_question="What went well?"
third_question="Did anything come up which you didn't expect?"
fourth_question="Did you learn anything? Unexpected or otherwise? (Don't always need to say yes)"
fifth_question="Anything else of note you'd like to mention?"

# Ask the day's questions
echo "Hey, ${user_first_name}. ${first_question}\n"
read todays_work

echo "\n\_(ツ)_/ \nOkie Dokie. ${second_question}\n"
read successes

echo "\n${third_question}\n"
read surprises

echo "\nOK. ${fourth_question}\n"
read i_learned

echo "\nAlrighty fine. ${fifth_question}\n"
read noteworthy

echo "\n"

# Create journal entry
jrnl "\n
  • ${first_question}
  ${todays_work}

  • ${second_question}
  ${successes}

  • ${third_question}
  ${surprises}

  • ${fourth_question}
  ${i_learned}

  • ${fifth_question}
  ${noteworthy}
  	"

osascript -e 'quit app "Terminal"'
# define function to take string and print as if hand typed, echo "String"|pv -qL 10
# "• ${first_question}\n${todays_work}\n\n• ${second_question}\n${successes}\n\n•${third_question}\n${surprises}\n\n•${fourth_question}\n${noteworthy}\n"
