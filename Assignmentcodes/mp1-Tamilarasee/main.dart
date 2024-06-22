import 'package:flutter/material.dart';

// contact section varaiables
class Userdetails{
  final String name;
  final String mail;
  final String phone;
  final String location;
  final String photoimagepath;

  const Userdetails({
    required this.name,
    required this.mail,
    required this.phone,
    required this.location,
    required this.photoimagepath,
   
  });
  
}

//Education section variables

class EducationDetails {
  final String college;
  final String name;
  final String gpa;
  final String imagepath;

  const EducationDetails({
    required this.college,
    required this.name,
    required this.gpa,
    required this.imagepath,
  });

}


//Experience section variables

class ExperienceDetails {
  final String name;
  final String location;
  final String title;
  final String duration;
  

  const ExperienceDetails({
    required this.name,
    required this.location,
    required this.title,  
    required this.duration  
    
  });

}

//Project section variables
class ProjectDetails {
  final String name;
  final String imagepath;
  final String description;
  

  const ProjectDetails({
    required this.name,
    required this.imagepath,
    required this.description,    
    
  });

}

// custom widget for contact display

class ContactDisplay extends StatelessWidget{
  final IconData icon;
  final String contact;

  const ContactDisplay({super.key, required this.icon,required this.contact});

  @override
  Widget build(BuildContext context) {
    return 
    Container(
      padding: const EdgeInsets.all(10),
      
      child:
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Icon(icon), 
           const SizedBox(width: 10),
                    Text(contact)
        ]
      )
    );
  }
}
      

// custom widget for Education display

class EducationDisplay extends StatelessWidget{
  final EducationDetails degree;

  const EducationDisplay({super.key, required this.degree});

  @override
  Widget build(BuildContext context) {
    return 
    Container(
      padding: const EdgeInsets.all(10),
      width: 400,
      child:
      Row(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Image.asset(degree.imagepath,
                      width:50,
                      height:50,),
          const SizedBox(width: 50),
          Expanded(child:
          Column(
            children:[
              Text(degree.college,style: TextStyle(fontSize: 20)),
              Text(degree.name,style:  TextStyle(fontSize: 20))
            ]
          ),
          ),
          const SizedBox(width: 50),  
          Column(
            children:[
              const Text('GPA',style: TextStyle(fontSize: 20)),
              Text(degree.gpa,style: TextStyle(fontSize: 20)),
            ]
          ),         
        
      ],),
    
      );    }
}

// custom widget for Experience display

class ExperienceDisplay extends StatelessWidget{
  final ExperienceDetails experience;


  const ExperienceDisplay({super.key, required this.experience});

  @override
  Widget build(BuildContext context) {
    return 
    
    Container(
      padding: const EdgeInsets.all(10),
      width: 650,
      child:
      
      Row(  
                   
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
                    
            Expanded(child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              Text(experience.name,style: TextStyle(fontSize: 20,)),
              Text(experience.title,style: TextStyle(fontSize: 20,))
            ]
          )
          )
          ,
          const Text('-',style: TextStyle(fontSize: 30,)),
          const SizedBox(width: 40),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              Text(experience.location,style: TextStyle(fontSize: 20,)),
              Text(experience.duration,style: TextStyle(fontSize: 20,))
            ]
          ),
                   
      ],
      ),
    
      );  
    
      }
}



// custom widget for Projects display

class ProjectDisplay extends StatelessWidget{
  final ProjectDetails project;
  final Map<String,double> imagesize;

  const ProjectDisplay({super.key, required this.project,required this.imagesize});

  @override
  Widget build(BuildContext context) {
    return 
    Container(
      padding: const EdgeInsets.all(30),
      child:
      Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Text(project.name,
          style: TextStyle(fontSize: 25, color: Colors.blueGrey)),
          Image.asset(project.imagepath,
                      width:imagesize['width'],
                      height:imagesize['height'],),
          
          Container(
            width:imagesize['width'],            
            child:
          Text(project.description,
          style: TextStyle(fontSize: 15),
           ),
          ),          
            ]),    
          
          );}
}



// Root widget

class Profilepage extends StatelessWidget {
  final Userdetails user;
  final Set<EducationDetails> education;
  final List<ProjectDetails> project;  
  final List<ExperienceDetails> experience;

  const Profilepage({super.key, required this.user, required this.education,required this.project,required this.experience});

  @override
  Widget build(BuildContext context) {  


    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile Page'),
      ),
      
      body: 
      Center(        
        child:
      SingleChildScrollView(
          // padding: EdgeInsets.symmetric(horizontal: 10.0),
          scrollDirection: Axis.horizontal,
          child:(   

      Container(      

          width:1500,
          alignment: Alignment.center,
          child:

       ListView(
        children: [              
          ListTile(           
              tileColor: Color.fromRGBO(234, 237, 235, 1),   

          subtitle: 

         Padding(
           padding: const EdgeInsets.all(8.0),
           child: Row(
            mainAxisAlignment:MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

            Image.asset(user.photoimagepath,
                        width:120,
                        height:120),

            const SizedBox(width: 20),
             
            Column(       
                     mainAxisAlignment:MainAxisAlignment.center,
                     crossAxisAlignment:CrossAxisAlignment.center ,
                    children: [
                      
                    Text(user.name,
                    style: TextStyle(fontSize: 40, color: Color.fromRGBO(8, 8, 8, 0.99)),
                    ), 
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
           
                      children:[
                      ContactDisplay(icon: Icons.mail, contact: user.mail),
                      ContactDisplay(icon: Icons.phone, contact: user.phone),
                      ContactDisplay(icon: Icons.location_on, contact: user.location),
                      ]),                      
                  ],),                   
               ],),
         )),
              
           
          ListTile(           
              tileColor: Color.fromRGBO(223, 229, 223, 1),
              title: Center(child: const Text('Education',
                  style: TextStyle(fontSize: 30,color:Color.fromRGBO(8, 133, 235, 0.859)),
                  )) , 
          subtitle: 
          
          Column(  

            children: 
            [  
                            
              const SizedBox(height: 20),           
              
              Column(

                children:                  
                  education.map((degree) => EducationDisplay(degree: degree)).toList(),

                  ),
              const SizedBox(height: 40),          
            ]),
          
          ),

          
          ListTile(           
              tileColor: Color.fromRGBO(215, 218, 216, 1),
              title: Center(child: const Text('Professional background',
                  style: TextStyle(fontSize: 30,color: Color.fromRGBO(5, 9, 250, 0.651)),) ),
          subtitle: 
          
          Column(
            children: 

            [              
              const SizedBox(height: 20),                         
                         
              Column(
                children:                  
                  experience.map((item) => ExperienceDisplay(experience: item)).toList(),
                          
              ),
              const SizedBox(height: 40),
            ]),         
          ),

          
          ListTile(           
              tileColor: Color.fromRGBO(201, 203, 201, 1),
              title: Center(child: 
              const Text('Projects',style: TextStyle(fontSize: 30, color: Color.fromARGB(255, 121, 76, 235)),)),
          subtitle: 
          
          Column(
            children:
            [

               const SizedBox(height: 20),        

              ProjectDisplay(project: project[0],imagesize: {'width': 800, 'height': 400}),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                children: 
                  project.sublist(1).map((item) => ProjectDisplay(project: item, imagesize: {'width': 400, 'height': 300})).toList()
              )
              ])
          
          )                   
        ] )      
        ) )
          )   
      )
      );}
}




void main() {

  const user =  Userdetails(
      name: 'Tamilarasee Sethuraj',
      mail: 'tsethuraj@hawk.iit.edu',
      phone: '+1 123456789',
      location: 'Chicago, IL',
      photoimagepath:'assets/images/photo.jpg' );

    const education = {
      
      
      EducationDetails(
        college: 'Illinois Tech',
        name: 'MS in CS',
        gpa: '4.0',
        imagepath: 'assets/images/iit.jpg'
        ),
      
      EducationDetails(
        college: 'Anna University',
        name: 'BE in ECE',
        gpa: '4.0',
        imagepath: 'assets/images/annauniversity.png'
        ),
   
      };

      const project = [    
      
      ProjectDetails(
        name: 'Road Traffic Management System',        
        imagepath: 'assets/images/traffic.jpg',
        description: 'A dynamic command line tool program using Python and SQL which provides details on the Traffic incidents, Signals, Roads, Vehicles in a Country based on the data stored in the database.',      
        ),
      
      ProjectDetails(
        name: 'Clothing Store Management System',        
        imagepath: 'assets/images/clothingstore.jpg',
        description: 'An interactive website for managing the inventory of clothing store involving product and customer order maintenance following the 3- tier software architecture',      
        ),

      ProjectDetails(
        name: 'Python Mini Projects',        
        imagepath: 'assets/images/miniprojects.jpg',
        description: 'A couple of improvised, popular mini projects and games in my path of learning Python'
        ),
   
      ];

      const experience = [
        ExperienceDetails(name: 'Accenture Solutions Pvt Ltd', location: 'Chennai,India', 
                          title: 'Application Development Senior Analyst', duration: 'Apr 2017 - Jun 2022'),
        ExperienceDetails(name: 'Gavs Technologies Pvt Ltd', location: 'Chennai,India', 
                          title: 'Senior Consultant', duration: 'Jun 2022 - Aug 2023')
      ];
    

  runApp(const MaterialApp(
        title: 'My Profile App',
        home: Profilepage(user: user,education: education,project: project, experience: experience),
        debugShowCheckedModeBanner: false));
  
}


