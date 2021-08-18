<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
xmlns:bv="http://finalassignment.org/XMLbigvir84Schema"				
xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="#all">
    <xsl:output method="xml" indent="yes"/> 
<!-- Create the root of the new tree called infoForVaccinus-->   
<xsl:template match="bv:citizens">
    <xsl:element name="bv:infoForVaccinus" xmlns:bv="http://finalassignment.org/XMLbigvir84Schema">
        <!-- Create 2 child element each will contain the citizen under 60 or over 60-->
        <xsl:element name="bv:citizensOver60" >
            <xsl:apply-templates select="bv:citizen[bv:medicalInformation/bv:age &gt;60]"/>
        </xsl:element>
        <xsl:element name="bv:citizensUnder60">
            <xsl:apply-templates select="bv:citizen[not(bv:medicalInformation/bv:age &gt;60)]"/>
        </xsl:element>
    </xsl:element>   
</xsl:template>

<!-- Template apply to citizen over 60. It will deep copy only the "medicalInformation" and
     the "medicalHistory" part of the citizens information. The data stays anonimized.-->
<xsl:template match="bv:citizen[bv:medicalInformation/bv:age &gt;60]">
    <xsl:element name="bv:citizen">
       <xsl:attribute name="citizenId"><xsl:value-of select="@idCitizen"/></xsl:attribute>
       <xsl:copy-of select="bv:medicalInformation" copy-namespaces="no"></xsl:copy-of>
       <xsl:copy-of select="bv:medicalHistory" copy-namespaces="no"></xsl:copy-of> 
    </xsl:element>
</xsl:template>

    <!-- Template apply to citizen under 60. It will deep copy only the "medicalInformation" and
     the "medicalHistory" part of the citizens information. The data stays anonimized.-->
<xsl:template match="bv:citizen[not(bv:medicalInformation/bv:age &gt;60)]">
    <xsl:element name="bv:citizen">
        <xsl:attribute name="citizenId"><xsl:value-of select="@idCitizen"/></xsl:attribute>
        <xsl:copy-of select="bv:medicalInformation" copy-namespaces="no" ></xsl:copy-of>
        <xsl:copy-of select="bv:medicalHistory" copy-namespaces="no"></xsl:copy-of>
    </xsl:element>
</xsl:template>    
    
<!-- Apply empty template to all the other nodes that are not citizen -->
<xsl:template match="/bv:BigVir2084_database/*[not(bv:citizen)]"/>
    
</xsl:stylesheet>