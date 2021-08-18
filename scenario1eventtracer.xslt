<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
xmlns:bv="http://finalassignment.org/XMLbigvir84Schema"				
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html"/>
<xsl:variable name="event" select="'evt003'"/> <!-- Targeted event, can be changed to get the information about another event fast -->
	<xsl:variable name="date" select="'2021-06-09'"/> <!-- Targeted date, can be changed to get the information about another date fast-->
<xsl:template match="/">		
	<html>
		<body>
			<h1 align="center"><u>Scenario n°1 : Track the citizens that participated to an event on a certain date</u></h1>
			<h2>Please call as soon as possible this list of <xsl:value-of select="count(//bv:citizen[bv:socialInformation/bv:socialHistory/bv:socialEvent[@date=$date]/bv:eventId=$event])"/> 
				citizens who participated to <xsl:value-of select="/bv:BigVir2084_database/bv:events/bv:event[@eventId=$event]/bv:name"/>
				on the <xsl:value-of select="$date"/>
			</h2>
			<table border="2"> <!-- Create the table that will store the information-->
				<tr bgcolor="#611c1e">
					<th style="color:white;">First name</th>
					<th style="color:white;">Surname</th>
					<th style="color:white;">Age</th>
					<th style="color:white;">Mail adress</th>
					<th style="color:white;">Phone number</th>
					<th style="color:white;">Referent general practitioner</th>
					<th style="color:white;">GP mail adress</th>
					<th style="color:white;">GP phone number</th>
					<xsl:apply-templates select="bv:BigVir2084_database/bv:citizens"/>
				</tr>
			</table>
		</body>
	</html>
</xsl:template>
<xsl:template match="bv:citizens">
	<xsl:apply-templates select="bv:citizen[bv:socialInformation/bv:socialHistory/bv:socialEvent[@date=$date]/bv:eventId=$event]">
		<!-- Sort the list of citizen who participated by age, so that the older ones can be called first -->
		<xsl:sort select="bv:personalInformation/bv:dateOfBirth"/>
	</xsl:apply-templates>		
</xsl:template>
	
<!--Get all the citizen that participated to the targeted event on the targeted date-->
	<xsl:template match="bv:citizen[bv:socialInformation/bv:socialHistory/bv:socialEvent[@date=$date]/bv:eventId=$event]">
	<tr>
		<td><b>
			<xsl:value-of select="bv:personalInformation/bv:name"/>
		</b></td>
		<td><b>
			<xsl:value-of select="bv:personalInformation/bv:surname"/>
		</b></td>
		<td><b>
			<xsl:value-of select="bv:medicalInformation/bv:age"/>
		</b></td>
		<td><b>
			<xsl:value-of select="bv:personalInformation/bv:mailAdress"/>
		</b></td>
		<td><b>
			<!--As the citizens have either a cell phone or a fixed number, it need a choose to get the right one -->
			<xsl:choose>
				<xsl:when test="bv:personalInformation/bv:fixPhoneNumber">
					<xsl:value-of select="bv:personalInformation/bv:fixPhoneNumber"/>
				</xsl:when>	
				<xsl:otherwise>
					<xsl:value-of select="bv:personalInformation/bv:mobilePhoneNumber"/>
				</xsl:otherwise>
			</xsl:choose>
		</b></td>
		<xsl:variable name="var2" select="bv:medicalInformation/bv:referentPhysicians/bv:referentPhysician[@speciality='general practitioner']/@refphysicianId"/>
		<td><b>
			<!-- get the information about the referent physcician that are stored in another node, using his id. Specifying the general practitioner speciality in case the citizen has 2 referent physicians with different specialities-->
			<xsl:value-of select="/bv:BigVir2084_database/bv:medicalServices/bv:medicalService[@medSerId=$var2]/bv:name"/>
			<xsl:value-of select="/bv:BigVir2084_database/bv:medicalServices/bv:medicalService[@medSerId=$var2]/bv:surname"/>
		</b></td>
		<td><b>
			<xsl:value-of select="/bv:BigVir2084_database/bv:medicalServices/bv:medicalService[@medSerId=$var2]/bv:mailAdress"/>
		</b></td>
		<td><b>
			<xsl:value-of select="/bv:BigVir2084_database/bv:medicalServices/bv:medicalService[@medSerId=$var2]/bv:phoneNumber"/>
		</b></td>	
	</tr>
</xsl:template>
</xsl:stylesheet>

