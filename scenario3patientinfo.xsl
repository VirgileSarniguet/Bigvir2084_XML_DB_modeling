<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
xmlns:bv="http://finalassignment.org/XMLbigvir84Schema"				
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html"/>
<xsl:variable name="citizenId" select="'cit003'"/> <!-- declare a globale variable : ID of the target citizen -->
<xsl:template match="/">
        <body>
            <h1 align="center"><u>Scenario n°3 : Patient History </u></h1>
            <!-- Display the name of the targeted citizen -->
            <h2 >Find below information of patient <xsl:value-of select="//bv:citizen[@idCitizen=$citizenId]/bv:personalInformation/bv:name"/><xsl:text>
            </xsl:text> <xsl:value-of select="//bv:citizen[@idCitizen=$citizenId]/bv:personalInformation/bv:surname"/></h2>
            <!-- Apply template to the targeted citizen -->
            <xsl:apply-templates select="//bv:citizen[@idCitizen=$citizenId]"/>
        </body>    
</xsl:template>
<!-- Template for the targeted citizens presenting first feneral information and then tables with his medical history -->
<xsl:template match="bv:citizen[@idCitizen=$citizenId]">
  
    <h3><u>General information</u></h3>
    <!-- Display all the general information regarding the targeted patient -->
    <p>Date of birth : <xsl:value-of select="bv:personalInformation/bv:dateOfBirth"/> </p>
    <p>Adress : <xsl:value-of select="bv:personalInformation/bv:adress"/><xsl:text>, </xsl:text><xsl:value-of select="//bv:citizen[@idCitizen=$citizenId]/bv:personalInformation/bv:zipcode"/> </p>   
    <p>Phone number :
    <!-- Test if the citizen has a fix or mobile number in the databse and display the available one -->    
        <xsl:choose>
            <xsl:when test="bv:personalInformation/bv:fixPhoneNumber">
                <xsl:value-of select="bv:personalInformation/bv:fixPhoneNumber"/>
            </xsl:when>	
            <xsl:otherwise>
                <xsl:value-of select="bv:personalInformation/bv:mobilePhoneNumber"/>
            </xsl:otherwise>
        </xsl:choose> 
    </p>
    <p>Mail Adress : <a><xsl:value-of select="bv:personalInformation/bv:mailAdress"/></a> </p>
    <p>Sex :
    <!-- Transform the M and F stored in the database in Male or Female -->    
        <xsl:choose>
            <xsl:when test="bv:medicalInformation/bv:sex='M'">
                <xsl:text>Male</xsl:text>
            </xsl:when>	
            <xsl:otherwise>
                <xsl:text>Female</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </p>
    <p>Weight: <xsl:value-of select="bv:medicalInformation/bv:weightKg"/> kg</p>
    <p>Height : <xsl:value-of select="(bv:medicalInformation/bv:heightCm) div 100"/> m</p> <!-- display the size in meter -->
    <!-- Display the list of all referent physicians and there specialities, use of for each to test if there are several referent physician -->
    <p>Referent Physicians : 
        <xsl:for-each select="bv:medicalInformation/bv:referentPhysicians/bv:referentPhysician">
            <xsl:variable name="refId" select="@refphysicianId"/>
            <xsl:value-of select="/bv:BigVir2084_database/bv:medicalServices/bv:medicalService[@medSerId=$refId]/bv:name"/>
            <xsl:text> </xsl:text>
            <xsl:value-of select="/bv:BigVir2084_database/bv:medicalServices/bv:medicalService[@medSerId=$refId]/bv:surname"/>
            <xsl:text> -- </xsl:text>
            <b><xsl:value-of select="@speciality"/></b><xsl:text> ; </xsl:text>
        </xsl:for-each>
    </p>
    <p>Allergies :
        <!-- If the citizen doesn't have allergies, it will display none. If he does, it will display the list of allergies -->
        <xsl:choose>
            <xsl:when test="bv:medicalInformation/bv:Allergies"><xsl:value-of select="bv:medicalInformation/bv:Allergies"/></xsl:when>
            <xsl:otherwise> None</xsl:otherwise>
        </xsl:choose> 
    </p>
    
    <h3><u>Medical history</u></h3>
    <h4>Medical acts</h4>
    <!-- Create a table for consultations -->
    <table border="1" > 
        <tr bgcolor="#5a711c" ><th colspan="4" style="color:white;"> Medical Acts </th> </tr>
        <tr bgcolor="#718d23" ><th colspan="4" style="color:white;" align="left"> Consultations </th> </tr>
        <tr bgcolor="#8db02c">
            <th style="color:white;">Date</th>
            <th style="color:white;">Physician</th>
            <th style="color:white;">Result</th>
            <th style="color:white;">Prescription</th>
        </tr>
        <!-- Fill up the consultation table with the information of each consultation -->
        <xsl:for-each select="bv:medicalHistory/bv:medicalActs/bv:consultation">
            <tr>
                <td><xsl:value-of select="@date"/></td>
                <td><xsl:value-of select="@refMedSerId"/></td>
                <td><xsl:value-of select="bv:consultationResult"/></td>
                <xsl:if test="bv:prescription">
                    <td><xsl:value-of select="bv:prescription"/></td>    
                </xsl:if>
                <xsl:if test="bv:medicalHistory/bv:medicalActs/bv:consultation/bv:generalComments">
                    <td><xsl:value-of select="bv:generalComments"/></td>
                </xsl:if>
            </tr>
        </xsl:for-each>
        </table>
    
    <!-- Create a table for Laboratory test only if some element "laboratory test" exist for this patient -->
    <xsl:if test="bv:medicalHistory/bv:medicalActs/bv:laboratoryTest">
        <table border="1">
        <tr bgcolor="#718d23" ><th colspan="5" style="color:white;" align="left"> Laboratory tests </th> </tr>
    <tr bgcolor="#8db02c">
        <th style="color:white;">Date</th>
        <th style="color:white;">Laboratory</th>
        <th style="color:white;">Pathologie tested</th>
        <th style="color:white;">Test result</th>
        <th style="color:white;">Result details</th>
    </tr>
   <!-- Fill up the "LaboratoryTest" table with information for each laboratory test-->        
    <xsl:for-each select="bv:medicalHistory/bv:medicalActs/bv:laboratoryTest">
        <tr>
            <td><xsl:value-of select="@date"/></td>
            <td><xsl:value-of select="@refMedSerId"/></td>
            <td><xsl:value-of select="bv:pathologieTested"/></td>
    <!-- Test if there is a "test result" to display and if yes transform the boolean in "positive" or "negative
    if there is no test result, it'll display "NA" -->
            <xsl:choose>
                <xsl:when test="bv:testResult">
                    <xsl:choose>
                        <xsl:when test="bv:testResult=0"><td>negative</td></xsl:when>
                        <xsl:otherwise><td>positive</td></xsl:otherwise>
                    </xsl:choose>    
                </xsl:when>
                <xsl:otherwise><td>NA</td></xsl:otherwise>
            </xsl:choose>
    <!-- Test if there is a result detail, if not, will disply "NA" -->
            <xsl:choose>
                <xsl:when test="bv:resultDetails">
                    <td><xsl:value-of select="bv:resultDetails"/></td>    
                </xsl:when>
                <xsl:otherwise><td>NA</td></xsl:otherwise>
            </xsl:choose>
        </tr>
    </xsl:for-each>
    </table>
    </xsl:if>
    <!-- Create a table for "Surgeries" only if some elements "surgery" exist for this patient -->
    <xsl:if test="bv:medicalHistory/bv:medicalActs/bv:surgery"> 
        <table border="1">
        <tr bgcolor="#718d23" ><th colspan="5" style="color:white;" align="left"> Surgeries </th> </tr>
        <tr bgcolor="#8db02c">
            <th style="color:white;">Date</th>
            <th style="color:white;">Surgeon</th>
            <th style="color:white;">Surgery description</th>
        </tr>
     <!-- Fill up the "Surgeries" table with information for each surgery-->
        <xsl:for-each select="bv:medicalHistory/bv:medicalActs/bv:surgery">
            <tr>
                <td><xsl:value-of select="@date"/></td>
                <td><xsl:value-of select="@refMedSerId"/></td>
                <td><xsl:value-of select="bv:interventionDescription"/></td>
            </tr>
        </xsl:for-each>
   </table>
   </xsl:if>
    <!-- Create a table for "Hospitalisations" only if some elements "hospitalisation" exist for this patient --> 
    <xsl:if test="bv:medicalHistory/bv:medicalActs/bv:hospitalisation">
        <table border="1">
        <tr bgcolor="#718d23" ><th colspan="5" style="color:white;" align="left">Hospitalisations </th> </tr>
        <tr bgcolor="#8db02c">
            <th style="color:white;">Date</th>
            <th style="color:white;">Hospital</th>
            <th style="color:white;">Reason</th>
            <th style="color:white;">Lenght in days</th>
        </tr> 
    <!-- Fill up the "Hospitalisations" table with information for each hospitalisation-->         
        <xsl:for-each select="bv:medicalHistory/bv:medicalActs/bv:hospitalisation">
            <tr>
                <td><xsl:value-of select="@date"/></td>
                <td><xsl:value-of select="@refMedSerId"/></td>
                <td><xsl:value-of select="bv:reason"/></td>
                <td><xsl:value-of select="bv:lengthInDays"/></td>
            </tr>
        </xsl:for-each>
    </table>
    </xsl:if>
    
    <p></p>
    
    <!-- Create a table for "infections" only if the element "infections" exist for this patient --> 
    <xsl:if test="bv:medicalHistory/bv:infections">
        <h4>Infections</h4>
        <table border="1"> 
        <tr bgcolor="#822721" ><th colspan="4" style="color:white;"> Infections </th> </tr>
        <tr bgcolor="#a33129">
            <th style="color:white;">Date</th>
            <th style="color:white;">Pathologie</th>
        </tr>
     <!-- Fill up the "infections" table with information for each infection -->  
        <xsl:for-each select="bv:medicalHistory/bv:infections/bv:infection">
            <tr>
                <td><xsl:value-of select="@date"/></td>
                <td><xsl:value-of select="@pathologie"/></td>
            </tr>
        </xsl:for-each>
    </table>
    </xsl:if>
    
    <p></p>
    
    <!-- Create a table for "Vaccinations" only if the element "vaccinationStatutes" exist for this patient --> 
    <xsl:if test="bv:medicalHistory/bv:vaccinationStatutes">
        <h4>Vaccins</h4>
        <table border="1"> 
            <tr bgcolor="#282d9f" ><th colspan="4" style="color:white;"> Vaccination status </th> </tr>
            <tr bgcolor="#3238c7">
                <th style="color:white;">Date</th>
                <th style="color:white;">Pathologie</th>
                <th style="color:white;">Up to date</th>
            </tr>
  <!-- Fill up the "Vaccinations" table with information for each vaccin-->       
            <xsl:for-each select="bv:medicalHistory/bv:vaccinationStatutes/bv:vaccin">
                <tr>
                    <td><xsl:value-of select="@date"/></td>
                    <td><xsl:value-of select="bv:pathologie"/></td>
   <!-- Transform the Boolean of the upToDate element to No or Yes -->
                    <xsl:choose>
                        <xsl:when test="bv:upToDate=0"><td>No</td></xsl:when>
                        <xsl:otherwise><td>Yes</td></xsl:otherwise>
                    </xsl:choose>
                </tr>
            </xsl:for-each>
        </table>
    </xsl:if> 
    
    <p></p>
    <!-- Create a table for "Immunization" only if the element "immunizationStatus" exist for this patient -->     
    <xsl:if test="bv:medicalHistory/bv:immunizationStatus">
        <h4>Immunization</h4>
        <table border="1"> 
            <tr bgcolor="#3c3c3c" ><th colspan="4" style="color:white;"> Immunization status </th> </tr>
            <tr bgcolor="#4b4b4b">
                <th style="color:white;">Test date</th>
                <th style="color:white;">Pathologie</th>
                <th style="color:white;">Result</th>
            </tr>
    <!-- Fill up the "Vaccinations" table with information for each pathologie-->
            <xsl:for-each select="bv:medicalHistory/bv:immunizationStatus/bv:pathologie">
                <tr>
                    <td><xsl:value-of select="@testDate"/></td>
                    <td><xsl:value-of select="bv:name"/></td>
                    <td><xsl:value-of select="bv:result"/></td>
                </tr>
            </xsl:for-each>
        </table>
    </xsl:if>
    
    
</xsl:template>

</xsl:stylesheet>