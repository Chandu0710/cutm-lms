document.getElementById('send-button').addEventListener('click', sendMessage);
document.getElementById('user-input').addEventListener('keypress', function (e) {
    if (e.key === 'Enter') {
        sendMessage();
    }
});

function toggleChatbot() {
    const chatbotContainer = document.getElementById('chatbot-container');
    chatbotContainer.classList.toggle('hidden');
    if (chatbotContainer.style.display === "none" || chatbotContainer.style.display === "") {
        chatbotContainer.style.display = "flex";
    } else {
        chatbotContainer.style.display = "none";
    }
}

function sendMessage() {
    const userInput = document.getElementById('user-input').value;
    if (userInput.trim() === '') return;

    addMessage(userInput, 'user-message');

    document.getElementById('user-input').value = '';

    // Simulate AI response
    setTimeout(() => {
        const botResponse = getBotResponse(userInput);
        addMessage(botResponse, 'bot-message');
    }, 500);
}

function addMessage(text, className) {
    const message = document.createElement('div');
    message.className = `message ${className}`;
    message.textContent = text;
    document.getElementById('chat-output').appendChild(message);
    document.getElementById('chat-window').scrollTop = document.getElementById('chat-window').scrollHeight;
}

function getBotResponse(userInput) {
    // Large set of responses
    const responses = {
        'hi': 'Hello! How can I help you today?',
        'hello': 'Hi there! What can I do for you?',
        'how are you': 'I\'m just a bot, but I\'m here to help!',
        'bye': 'Goodbye! Have a great day!',
        'what is the admission process': 'Our admission process involves filling out an application form, submitting required documents.',
        'what courses do you offer': 'We offer a variety of courses including Computer Science, Mechanical, Forensic, Marketing',
        'what are the fees for computer science': 'The fees for Computer Science are 50000 Rs per semester.',
        'when does the semester start': 'The semester starts on July 1st.',
        'what is the campus address': 'Our campus is located at Rollavaka Village Bondapalli, Mandal, Andhra Pradesh 535003, INDIA.',
        'what are the library hours': 'The library is open from 9 AM to 10 PM, Monday through Saturday.',
        'how can I apply for a scholarship': 'You can apply for a scholarship through our website by filling out the scholarship application form.',
        'who is the dean of the Soet': 'The dean of the college is Dr. Sunny Dayal.',
        'what is the contact number for admissions': 'You can contact admissions at +91 9885103594.',
        'what sports facilities are available': 'We have facilities for basketball, football, cricket, and badminton.',
        'do you offer online courses': 'Yes, we offer a range of online courses. You can find more information on our website.',
        'how can I access my student account': 'You can access your student account through the student portal on our website.',
        'what are the dormitory options': 'We offer single, double, and suite-style dormitory options.',
        'is there a cafeteria on campus': 'Yes, we have a cafeteria that offers a variety of meals and snacks.',
        'what are the career services offered': 'We offer career counseling, resume workshops, and job placement services.',
        'how can I join a student club': 'You can join a student club by signing up during the club fair or through the student portal.',
        'what is the refund policy for tuition fees': 'Our refund policy allows for a full refund if you withdraw before the start of the semester, and a partial refund if you withdraw within the first two weeks.',
        'do you have a gym on campus': 'Yes, we have a fully equipped gym available for all students.',
        'what is the alumni network': 'Our alumni network connects graduates with each other and provides career support and networking opportunities.',
        'how can I get a transcript': 'You can request a transcript through the registrars office or the student portal.',
        'what is the grading system': 'Our grading system follows the standard O,A-F scale, with O being the highest grade.',
        'how can I contact my professor': 'You can contact your professor via email or during their office hours.',
        'what is the policy on plagiarism': 'Our policy on plagiarism is strict, and any instances are subject to disciplinary action.',
        'do you offer study abroad programs': 'Yes, we offer a variety of study abroad programs. More information is available on our website.',
        'how can I change my major': 'You can change your major by filling out the change of major form and submitting it to the registrar’s office.',
        'what are the graduation requirements': 'Graduation requirements include completing all course requirements, maintaining a minimum GPA, and completing a capstone project.',
        'how can I participate in research projects': 'You can participate in research projects by contacting your department or professors directly.',
        'what is the campus security policy': 'Our campus security policy includes 24/7 security patrols, emergency alert systems, and secure access to buildings.',
        'do you have a health center on campus': 'Yes, we have a health center that provides medical and counseling services to students.',
        'what are the dining options near campus': 'There are several dining options near campus, including cafes, restaurants, and fast-food outlets.',
        'how can I get involved in community service': 'You can get involved in community service through our volunteer office or by joining a student club.',
        'what is the policy on attendance': 'Attendance policies vary by course, but minimum 75% attendance is expected for all classes.',
        'how can I get academic advising': 'You can get academic advising by scheduling an appointment with your academic advisor through the student portal.',
        'do you offer graduate programs': 'Yes, we offer a variety of graduate programs. More information is available on our website.',
        'how can I access the campus Wi-Fi': 'You can access the campus Wi-Fi by logging in with your student credentials.',
        'how can I submit a complaint': 'You can submit a complaint through the student portal or by contacting the deans office.',
        'do you offer internships': 'Yes, we offer internships in collaboration with various companies and organizations.',
        'what is the policy on alcohol on campus': 'Our policy on alcohol prohibits consumption and possession of alcohol on campus.',
        'how can I get a student ID card': 'You can get a student ID card from the registrars office or during orientation.',
        'what is the role of the student council': 'The student council represents the student body and organizes events and activities.',
        'do you offer tutoring services': 'Yes, we offer tutoring services for a variety of subjects. You can sign up through the student portal.',
        'how can I access the library resources online': 'You can access library resources online through the librarys website using your student credentials.',
        'what are the IT support hours': 'IT support is available from 8 AM to 8 PM, Monday through Friday.',
        'how can I reserve a study room': 'You can reserve a study room through the librarys website or in person at the library.',
        'what are the requirements for international students': 'International students must provide proof of English proficiency, a valid passport, and financial statements.',
        'how can I apply for on-campus jobs': 'You can apply for on-campus jobs through the student employment office or the student portal.',
        'what is the campus smoking policy': 'Our campus is smoke-free, and smoking is prohibited in all areas.',
        'how can I get a copy of my course syllabus': 'You can get a copy of your course syllabus from your professor or through the course management system.',
        'do you offer career counseling': 'Yes, we offer career counseling services to help students with job searches, resume writing, and interview preparation.',
        'how can I join the student newsletter': 'You can join the student newsletter by signing up through the student portal or contacting the communications office.',
        'what is the policy on academic probation': 'Students on academic probation must meet with an academic advisor and may be required to take additional support courses.',
        'how can I transfer credits from another college': 'You can transfer credits by submitting your transcripts to the registrars office for evaluation.',
        'do you have a mentorship program': 'Yes, we have a mentorship program that pairs students with alumni and professionals in their field of study.',
        'what are the options for transportation': 'Transportation options include campus shuttles, college buses.',
        'what is the policy on late assignments': 'Policies on late assignments vary by course, but generally, late submissions may incur a penalty.',
        'how can I participate in athletics': 'You can participate in athletics by trying out for a team or joining an intramural sports league.',
        'what are the requirements for graduation': 'Requirements for graduation include completing all required courses, maintaining a minimum GPA, and completing a capstone project.',
        'how can I get help with my resume': 'You can get help with your resume through the career services office.',
        'do you offer summer classes': 'Yes, we offer a variety of summer classes. You can find more information on our website.',
        'what is the policy on pets on campus': 'Pets are not allowed on campus, except for service animals.',
        'how can I get a replacement student ID card': 'You can get a replacement student ID card from the registrars office.',
        'what are the available student services': 'Available student services include academic advising, counseling, career services, and health services.',
        'how can I find off-campus housing': 'You can find off-campus housing through the housing office or by checking local rental listings.',
        'what is the policy on discrimination': 'Our policy on discrimination is zero tolerance, and any instances should be reported to the deans office.',
        'how can I join a fraternity or sorority': 'You can join a fraternity or sorority by participating in the recruitment process.',
        'what are the campus dining options': 'Campus dining options include the cafeteria, food courts',
        'how can I register for classes': 'You can register for classes through the student portal during the registration period.',
        'what are the study abroad opportunities': 'Study abroad opportunities include exchange programs, internships, and short-term study tours.',
        'how can I contact campus security': 'You can contact campus security at (123) 456-7890 or through the emergency phones located around campus.',
        'what is the refund policy for housing fees': 'Our refund policy for housing fees allows for a full refund if you cancel before the start of the semester, and a partial refund if you cancel within the first two weeks.',
        'how can I get involved in research': 'You can get involved in research by contacting your professors or the research office.',
        'what are the available majors and minors': 'Available majors and minors include a wide range of disciplines in arts, sciences, and professional studies.',
        'how can I participate in student government': 'You can participate in student government by running for a position or joining a committee.',
        'what is the policy on academic integrity': 'Our policy on academic integrity requires honesty and prohibits cheating, plagiarism, and other forms of academic misconduct.',
        'how can I get help with financial planning': 'You can get help with financial planning through our financial aid office and counseling services.',
        'what is the process for transferring schools': 'The process for transferring schools involves submitting an application, transcripts, and meeting with an academic advisor.',
        'how can I stay informed about campus events': 'You can stay informed about campus events through the student portal, campus bulletin boards, and the student newsletter.',
        'what are the total program fees for AIML': 'The total program fees for the AIML are 115000/-.',
        'are there any additional fees apart from tuition, such as registration fees or exam fees': 'Apart from tuition fees, there are additional fees such as registration fees and exam fees.',
        'can I get detailed information about the fee structure, including semester-wise breakdow': 'Detailed information about the fee structure, including semester-wise breakdown, can be provided upon request. Please contact the universitys administration office for more information.',
        'are there any scholarships or financial aid options available to help cover the program fees?': 'Centurion University offers various scholarships and financial aid options to eligible students to help cover program fees. You can find more information about available scholarships and how to apply on the universitys website or by contacting the financial aid office.',
        'when are hostel fees due, and what are the payment options available': 'Hostel fees are typically due at the beginning of each semester. Payment options include online transfers and installment plans.',
        'what is the fee structure for hostel accommodation?': 'Hostel fees vary based on room type and facilities. Refer to the hostel fee schedule for details.',
        'how will skill courses benefit my career prospects?': 'Completing skill courses can enhance your resume, expand your professional network, and increase your job prospects in your chosen field.',
        'what are the fees for skill courses?': 'Course fees vary. Refer to the course description or contact us for current pricing information.',
        'how can I register for skill courses?': 'Register online through our website or contact  for assistance with enrollment. https://cutmap.ac.in/contact/.',
        'what skill courses are available for students?': 'We offer a variety of skill courses. Check our website https://cutm.ac.in/admission/school/skill-certificate/.',
        'are there support services available to help students with scholarship applications?': 'Access workshops and resources for help with scholarship applications through the financial aid office https://cutmap.ac.in/admission/scholarship/.',
        'what are the eligibility criteria for applying for scholarships?': 'Criteria vary by scholarship and may include academic merit, financial need, and other factors. Check the university website for details https://cutmap.ac.in/admission/scholarship/.'
    };

    const defaultResponse = 'I\'m not sure how to respond to that. Can you try asking something else?';

    return responses[userInput.toLowerCase()] || defaultResponse;
}
