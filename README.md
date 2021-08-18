# Bigvir2084_XML_DB_modeling

This report aims at presenting the selected model design of XML database using the XML schema. I will also discuss the modeling choices and their advantages/disadvantage. In a second part, will be exposed the different scenarios that the XSLT will answer. Eventually, the tools and environment used for the whole project will be listed in a last part.

## 1) The XML database

###  a. The XML schema
  The BigVir2084’s app database aims at gathering a maximum of information about citizens and their medical information/history, but also information on events and places. In the end, the goal of the application among other things is to be able to warn citizens about hazardous situation and provide information to the decision makers at state level to implement different measures (like closing a place, cancel an event, impose a lockdown…). 

  This database has thus multiple functions for different type of users: citizens, doctors, the National Health Agency etc. It needs to have a specific segmentation in order to serve those different purposes.
  
  Furthermore, it is important to consider that the different types of users will have different access rights: 
  * Citizens will only have access to their own __personal, medical,__ and __social__ information.
  * Medical services (physician, hospitals, laboratories) will only have access to their patient __personal__ and __medical__ information, and while be able to update citizens’ medical information.
  * The National Health Agency and the Global Health Observatory can access the whole data base, including events, places, medical services and citizen information. The unique difference between those 2 entities is that the NHA can update any information in the database while the GHO can only read the information.
  * The National Health Agency can also give access to part of the data if anonymized to some external users as investigation laboratories, private companies, states etc. The NHA will then decide what access right will be given on a case-by-case basis according to the external user.

The schema must then allow easy manipulation of data transformation for all types of users. The information must stay readable for any type of user inside the database, avoiding extensive use of attributes and make sure the necessary information is at the right place.

As this data base might be used in combination with other health data someday, it is important to use a namespace. As different users while input some data, it is important to have restriction on the input to assure the uniformity of data.

### b. Schema description, advantages and disadvantages

  The database is split in 4 main nodes: citizens, medical services, events and public places. First, because it avoids redundancy in the data base. Indeed, it allows to have a maximum of information about each entity and reference it with and id. Some key-keyref constraints are used to make sure existing entities are referred in the citizen’s part. Secondly because this way, it will be easier to manage transformations especially for remodeling or using part of the database according to the access right policies. The drawback can be that the information can be very far away from each other in the data base and that it creates extra nodes.
  
  The most important node is citizens where all the most sensitive data is stored. Here, the information is split in 4 nodes for each citizen: personal information, medical information, medical history and social information. The aim of separating the personal from medical information is to easily anonymize the data. Indeed, the only sensitive information is stored in the personal information part. Separating medical from social information has the same goal, a doctor for instance can access the medical information part but not the social information part. The draw back here is only that this creates extra layers in the tree and a bit of redundancy (age and date of birth for instance). 
  
  An interesting part of the citizen nodes is the medical acts. As the acts are quite different regarding the information needed (for instance a laboratory test compared to a surgery) it has been decided to create a basis type name acts, and some extensions for all the type of acts (consultation, surgery etc…). This allows to force the medical service to input the maximum of information with restrictions, compare to a single element composed of a lot of optional elements for all the different acts.

  The 3 other main nodes: medical services, events and public places are quite simple as they just store information on entities that are referred with their ids in the citizen part.

## 2)	XSLT transformations scenarios

### a. Scenario n°1: NHA’s contact case tracker for event and public places. 

The bigvir2084 is very contagious and can kill very fast. That is why the National Health Agency needs to know as fast as possible which citizens are contact cases, to warn them and make them do a test. The NHA asked its IT department to create 2 XSLT that can display a list of all the citizens that were present either at a specified event or place on a certain date (event id/place id and date as input). This way, they will be able to provide this list to their call center and call the contact cases as fast as possible so that they isolate themselves quickly. They also need to get the information of the referent general practitioner of each contact case, to warn them as well so that they can write their patient a prescription for a bigvir2084 test. As the most sensitive citizens to the bigvir2084 are the oldest, the list must be ordered by descending age, so that the oldest can be called before. This will require the use of the whole database, which is ok as the NHA is granted a full access to its own database.

### b. Scenario n°2: Vaccination campaign statistics for the GHO

To know if the vaccination campaign is going well, the Global Health Observatory would like to have first, some general statistics regarding the population and then some statistics on the vaccination campaign against bigvir2084. They want to know the percentage of people who have been vaccinated among the whole population but also specifically among the categories of people who have the highest risk to die from the disease: citizens over 60 years old, citizens who have already been infected by the Malaria and overweight citizens, meaning citizens who have an IMC (weight/ (height)^2) superior to 25.

Their goal was to have 75% of people vaccinated in those sensitive categories, and 50% for the less sensitive and the global population.

### c. Scenario n°3: patient information access for medical services

In order to facilitate the diagnosis and understanding of their patients' cases during this terrible pandemic, the medical services would need to have access to their patient medical information, historic and personal information. Nevertheless, the access right policy of the database only grants them access to their own patient medical and personal information, as specified in the access right policies of the database.

### d. Scenario n°4: database remodeling for Vaccinus company

The Vaccinus company had asked the National Heatlh Agency to have access to its bigvir2084 database for some investigation regarding the elder citizen. The National Health Agency agreed to provide the necessary to the Vaccinus company but with anonymized data, to be GDPR compliant. Meaning no personal data that could identify any citizen (Name, Address, Phone number, Birthdate etc.), and only the medical information and medical history (no social data). The National Health Agency thus needs a transformation to remodel the database, to remove all personal information and separate data of citizens over 60 in one part, and under 60 in another part for comparison.

## 3)	Tools and environment
  * Computer environment: Windows pc
  *	XML, XSD and XSLT editor: Oxygen XML Editor 23.1 (evaluation version)
  *	XML version: 1.0
  *	XSLT version: 2.0 (to be able to use variables in the xpath of <template match=xpath>). So that the users only have to change a global variable as input .
  *	HTML viewer: Mozilla Firefox 89.0.1 (64 bit)
