<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="tei" version="2.0">
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>
    <xsl:template match="/">
        <myindex>
        <h1>Projet : </h1>
        
        <xsl:for-each select=".//head">
        <p align="justify">
            <xsl:value-of select="."/>
            <br/>
        </p>
        </xsl:for-each>

        
        <h2>Première partie :</h2>
        <ul>
        
        <xsl:for-each select=".//part[@n='1']/subpart">
          <li>
          <p align="justify">
                <xsl:value-of select="."/>
                
                    <br/>
                </p>
            </li>
            
        </xsl:for-each>
        </ul>
        
        <h2>Seconde partie :</h2>
        <ul>
        <xsl:for-each select=".//part[@n='2']/subpart">
          <li>
          <p align="justify">
                <xsl:value-of select="."/>
                
                    <br/>
                </p>
            </li>
        </xsl:for-each>
        </ul>
        
        <h2>Conclusion :</h2>
        <p align="justify">
                <xsl:value-of select=".//foot"/>
            </p>
        </myindex>
    </xsl:template>


</xsl:stylesheet>