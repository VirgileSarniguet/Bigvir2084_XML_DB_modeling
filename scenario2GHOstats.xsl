<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
xmlns:bv="http://finalassignment.org/XMLbigvir84Schema"				
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html"/>   
<xsl:template match="/"> 
    <html>
        <body>
            <h1 align="center"><u>Scenario n°2 :General Health Organization statistics</u></h1>
            <h2> General statistics for the sample of <xsl:value-of select="count(//bv:citizen)" /> citizens :</h2>
                <xsl:apply-templates select="/bv:BigVir2084_database/bv:citizens"/>
            <h2> Specific statistics for the vaccination campain against BigVir2084 on the sample of <xsl:value-of select="count(//bv:citizen)" /> citizens :</h2>
            
            <!-- Create the table that will store the information-->
            <table border="1" align="center"> 
                <tr bgcolor="#621b1d" ><th colspan="4" style="color:white;"> Sensitive population </th> </tr>
                <tr bgcolor="#621b1d">
                    <th style="color:white;">Population Categories</th>
                    <th style="color:white;">Total</th>
                    <th style="color:white;">Vaccined</th>
                    <th style="color:white;">Vaccined in %</th>
                </tr>
                <tr>
                    <!-- Create a variable that is the number of citizen that are over 60 years old-->
                    <xsl:variable name="over60" select="count(//bv:citizen[bv:medicalInformation/bv:age>=60])"/>
                    <!-- Create a variable that is the number of citizen that are over 60 years old and got vaccinated against bigvir84-->
                    <xsl:variable name="vacover60" select="count(//bv:citizen[bv:medicalInformation/bv:age>=60 and  
                        bv:medicalHistory/bv:vaccinationStatutes/bv:vaccin/bv:pathologie='bigvir84'])"/>   
                        <td>Citizens over 60 years old</td>
                        <td align="right"><xsl:value-of select="$over60"/></td>
                        <td align="right"><xsl:value-of select="$vacover60"/></td>
                    
                    <!-- Test if the % of vaccined citizen over 60 is less than 75%, if it is , the number is display in red-->
                    <xsl:choose> 
                            <xsl:when test="round($vacover60 div $over60 * 100) &lt; 75 ">
                                <td align="right" style="color:red;"><xsl:value-of select="round($vacover60 div $over60 * 100)"/></td> 
                            </xsl:when>
                            <xsl:otherwise>
                                <td align="right"><xsl:value-of select="round($vacover60 div $over60 * 100)"/></td>    
                            </xsl:otherwise>
                        </xsl:choose>
               </tr>
                <tr>
                    <!-- Create a variable that is the number of citizen that already had malaria-->
                    <xsl:variable name="malaria" select="count(//bv:citizen[bv:medicalHistory/bv:infections/bv:infection/@pathologie='malaria'])"/>
                    <!-- Create a variable that is the number of citizen that already had malaria and got vacined against bigvir84-->
                    <xsl:variable name="vacmalaria" select="count(//bv:citizen[bv:medicalHistory/bv:infections/bv:infection/@pathologie='malaria' and 
                        bv:medicalHistory/bv:vaccinationStatutes/bv:vaccin/bv:pathologie='bigvir84'])"/>
                    <td>Citizens that already had malaria</td>
                    <td align="right"><xsl:value-of select="$malaria"/></td>
                    <td align="right"><xsl:value-of select="$vacmalaria"/></td>
                    
                    <!-- Test if the % of vaccined citizen that got malaria is less than 75%, if it is , the number is display in red-->
                    <xsl:choose> 
                        <xsl:when test="round($vacmalaria div $malaria * 100) &lt; 75">
                            <td align="right"><font color="red"><xsl:value-of select="round($vacmalaria div $malaria * 100)"/></font></td>
                        </xsl:when>
                        <xsl:otherwise>
                            <td align="right"><xsl:value-of select="round($vacmalaria div $malaria * 100)"/></td>
                        </xsl:otherwise>  
                    </xsl:choose> 
                 </tr>
                 <tr>
                        <!-- Create a variable that is the number of citizen that have an IMC (weight in kg/(height in meter ^2)) > 25-->
                        <xsl:variable name="overweight" select="count(//bv:citizen[bv:medicalInformation/bv:weightKg div (bv:medicalInformation/bv:heightCm div 100 * bv:medicalInformation/bv:heightCm div 100) > 25 ])"/>
                        <xsl:variable name="vacoverweight" select="count(//bv:citizen[bv:medicalInformation/bv:weightKg div (bv:medicalInformation/bv:heightCm div 100 * bv:medicalInformation/bv:heightCm div 100) > 25 and bv:medicalHistory/bv:vaccinationStatutes/bv:vaccin/bv:pathologie='bigvir84'])"/>
                        <td>Overweight citizens (IMC>25)</td>       
                        <td align="right"><xsl:value-of select="$overweight"/></td>
                        <td align="right"><xsl:value-of select="$vacoverweight"/></td>
                        <xsl:choose>
                            <xsl:when test="round($vacoverweight div $overweight * 100) &lt; 75">
                                <td align="right"><font color="red"><xsl:value-of select="round($vacoverweight div $overweight * 100)"/></font></td>
                            </xsl:when>
                            <xsl:otherwise>
                                <td align="right"><xsl:value-of select="round($vacoverweight div $overweight * 100)"/></td>
                            </xsl:otherwise>
                        </xsl:choose>
                 </tr>

            </table>
            <center><i><font size="3">Targeted minimum % for sensitive population : 75%</font></i></center>
            <p></p>
            <!-- Creat a second table with the rest of population -->
            <table border="1" align="center">
            <tr bgcolor="#621b1d" ><th colspan="4" style="color:white;"> Rest of the population </th> </tr>
            <tr bgcolor="#621b1d">
                <th style="color:white;">Population Categories</th>
                <th style="color:white;">Total</th>
                <th style="color:white;">Vaccined</th>
                <th style="color:white;">Vaccined in %</th>
            </tr>
            <tr>
                <!-- Create a variable that is the number of citizen that are under 60 years old-->
                <xsl:variable name="under60" select="count(//bv:citizen[bv:medicalInformation/bv:age &lt; 60])"/>
                <!-- Create a variable that is the number of citizen that are under 60 years old and got vaccinated against bigvir84-->
                <xsl:variable name="vacunder60" select="count(//bv:citizen[bv:medicalInformation/bv:age &lt; 60 and
                bv:medicalHistory/bv:vaccinationStatutes/bv:vaccin/bv:pathologie='bigvir84'])"/>
                <td>Citizens under 60 years old</td>
                <td align="right"><xsl:value-of select="$under60"/></td>
                <td align="right"><xsl:value-of select="$vacunder60"/></td>
                
                <!-- Test if the % of vaccined citizen over 60 is less than 50%, if it is , the number is display in red-->
                <xsl:choose> 
                    <xsl:when test="round($vacunder60 div $under60 * 100) &lt; 50 ">
                        <td align="right"><font color="red"><xsl:value-of select="round($vacunder60 div $under60 * 100)"/></font></td> 
                    </xsl:when>
                    <xsl:otherwise>
                        <td align="right"><xsl:value-of select="round($vacunder60 div $under60 * 100)"/></td>    
                    </xsl:otherwise>
                </xsl:choose>     
            </tr>
            <tr>
                <!-- Create a variable that is the number of citizen -->
                <xsl:variable name="total" select="count(//bv:citizen)"/>
                <!-- Create a variable that is the number of citizen that got vaccinated against bigvir84-->
                <xsl:variable name="vactotal" select="count(//bv:citizen[bv:medicalHistory/bv:vaccinationStatutes/bv:vaccin/bv:pathologie='bigvir84'])"/>
                <td>Total population</td>
                <td align="right"><xsl:value-of select="$total"/></td>
                <td align="right"><xsl:value-of select="$vactotal"/></td>
                
                <!-- Test if the % of vaccined citizen over 60 is less than 50%, if it is , the number is display in red-->
                <xsl:choose> 
                    <xsl:when test="round($vactotal div $total * 100) &lt; 50 ">
                        <td align="right"><font color="red"><xsl:value-of select="round($vactotal div $total * 100)"/></font></td> 
                    </xsl:when>
                    <xsl:otherwise>
                        <td align="right"><xsl:value-of select="round($vactotal div $total * 100)"/></td>    
                    </xsl:otherwise>
                </xsl:choose>     
            </tr>
            </table>
            <center><i><font size="3">Targeted minimum % for the rest of population : 50%</font></i></center>
        </body>
    </html>
</xsl:template>
    
<xsl:template match="bv:citizens">
    <!-- Create a variable which is the sum of all the ages of all the citizen. This variable call a recursive template that calculate the sum (somme) -->
    <xsl:variable name="totalAge">
        <xsl:call-template name="somme">
            <xsl:with-param name="liste" select="//bv:citizens/bv:citizen/bv:medicalInformation/bv:age"/>
        </xsl:call-template>
    </xsl:variable>
    <!-- Create a variable which is the minimum of all the ages of all the citizens. This variable call a template that find the minimum (min).  -->
    <xsl:variable name="minage">
        <xsl:call-template name="min">
            <xsl:with-param name="nodes" select="//bv:citizens/bv:citizen/bv:medicalInformation/bv:age"/>
        </xsl:call-template>
    </xsl:variable>
    <!-- Create a variable which is the maximum of all the ages of all the citizens. This variable call a template that find the maximum (max).  -->
    <xsl:variable name="maxage">
        <xsl:call-template name="max">
            <xsl:with-param name="nodes" select="//bv:citizens/bv:citizen/bv:medicalInformation/bv:age"/>
        </xsl:call-template>
    </xsl:variable>
    <p>
        The average age of the citizens in the data base is <b><xsl:value-of select="$totalAge div count(//bv:citizen)"/></b> years old, 
        with a minimum of <b><xsl:value-of select="$minage"/></b> and a maximum of <b><xsl:value-of select="$maxage"/></b>
    </p>
    
    <!-- Create a variable which is the sum of all the ages of all the citizen. This variable call a recursive template that calculate the sum (somme) -->
    <xsl:variable name="totalWeight">
        <xsl:call-template name="somme">
            <xsl:with-param name="liste" select="//bv:citizens/bv:citizen/bv:medicalInformation/bv:weightKg"/>
        </xsl:call-template>
    </xsl:variable>
    <!-- Create a variable which is the minimum of all the ages of all the citizens. This variable call a template that find the minimum (min).  -->
    <xsl:variable name="minweight">
        <xsl:call-template name="min">
            <xsl:with-param name="nodes" select="//bv:citizens/bv:citizen/bv:medicalInformation/bv:weightKg"/>
        </xsl:call-template>
    </xsl:variable>
    <!-- Create a variable which is the maximum of all the ages of all the citizens. This variable call a template that find the maximum (max).  -->
    <xsl:variable name="maxweight">
        <xsl:call-template name="max">
            <xsl:with-param name="nodes" select="//bv:citizens/bv:citizen/bv:medicalInformation/bv:weightKg"/>
        </xsl:call-template>
    </xsl:variable>
    <p>
        The average weight of the citizens in the data base is <b><xsl:value-of select="$totalWeight div count(//bv:citizen)"/></b> kg, 
        with a minimum of <b><xsl:value-of select="$minweight"/></b> and a maximum of <b><xsl:value-of select="$maxweight"/></b>
    </p> 
    
    <!--Create a variable which is the total number of vaccins of all pathologies that have been occulated to all the citizens-->
    <xsl:variable name="totalVaccin">
        <xsl:call-template name="somme">
            <xsl:with-param name="liste" select="count(//bv:citizens/bv:citizen/bv:medicalHistory/bv:vaccinationStatutes/bv:vaccin)"/>
        </xsl:call-template>
    </xsl:variable>
    
    <!--Create a variable which is the minimum number of vaccin that received a citizen using sort and position -->
    <xsl:variable name="minvac"> 
        <xsl:for-each select="//bv:citizen/bv:medicalHistory/bv:vaccinationStatutes">
            <xsl:sort select="count(bv:vaccin)" order="ascending" />
            <xsl:if test="position(  ) = 1">
                <xsl:value-of select="count(bv:vaccin)"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:variable>
    
    <!--Create a variable which is the maximum number of vaccin for 1 citizen using sort and position -->
    <xsl:variable name="maxvac"> 
        <xsl:for-each select="//bv:citizen/bv:medicalHistory/bv:vaccinationStatutes">
            <xsl:sort select="count(bv:vaccin)" order="descending" />
            <xsl:if test="position(  ) = 1">
                <xsl:value-of select="count(bv:vaccin)"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:variable>
    <p>
        The average number of the vaccins the citizens have received is <b><xsl:value-of select="round($totalVaccin div count(//bv:citizen))"/></b> vaccins,
        with a minimum of <b><xsl:value-of select="$minvac"/></b> and a maximum of <b><xsl:value-of select="$maxvac"/></b>
    </p>
  
</xsl:template>

<!-- Recursive template to calculate the sum of the input parameter (here age and weight) -->
<xsl:template name="somme"> 
    <xsl:param name="liste"/>
    <xsl:choose>
        <xsl:when test="$liste">
            <xsl:variable name="var" select="$liste[1]"/>
            <xsl:variable name="autres">
                <xsl:call-template name="somme">
                    <xsl:with-param name="liste"
                        select="$liste[position() != 1]"/>
                </xsl:call-template>
            </xsl:variable>
            <xsl:value-of select="$var + $autres"/>
        </xsl:when>
        <xsl:otherwise>0</xsl:otherwise>
    </xsl:choose>
</xsl:template>
 
<!-- template to find the minimum of the input parameter : a certain node--> 
<xsl:template name="min"> 
    <xsl:param name="nodes" select="/.." />
    <xsl:choose>
        <xsl:when test="not($nodes)">NaN</xsl:when>
        <xsl:otherwise>
            <xsl:for-each select="$nodes">
                <xsl:sort data-type="number" />
                <xsl:if test="position(  ) = 1">
                    <xsl:value-of select="number(.)" />
                </xsl:if>
            </xsl:for-each>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<!-- template to find the maximum of the input parameter : a certain node-->
<xsl:template name="max">
    <xsl:param name="nodes" select="/.." /> 
    <xsl:choose>
        <xsl:when test="not($nodes)">NaN</xsl:when>
        <xsl:otherwise>
            <xsl:for-each select="$nodes">
                <xsl:sort data-type="number" order="descending" />
                <xsl:if test="position(  ) = 1">
                    <xsl:value-of select="number(.)" />
                </xsl:if>
            </xsl:for-each>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>   
</xsl:stylesheet>