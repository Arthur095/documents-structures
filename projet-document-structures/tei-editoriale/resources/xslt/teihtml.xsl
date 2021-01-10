<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xmln="http://www.w3.org/1999/xhtml" exclude-result-prefixes="tei xs xmln" version="2.0">
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>
    <xsl:template match="/">
        <tei>
        <h1>
            <xsl:value-of select=".//tei:front/tei:head"/>
        </h1>
        <xsl:for-each select=".//tei:body/tei:p">
        <xsl:choose>
        <xsl:when test=".[@part='I']">
            <h2>
                        <xsl:value-of select="."/>
                    </h2>   
        </xsl:when>
        <xsl:when test=".[@part='Y']">
            <h3>
                        <xsl:value-of select="."/>
                    </h3>   
        </xsl:when>
        <xsl:otherwise>
            <p>
                        <xsl:value-of select="."/>
                    </p>
        </xsl:otherwise>
        </xsl:choose>
        </xsl:for-each>
        <div id="teitable">
            <table>
                <tr>
                    <td>
                        Auteur
                    </td>
                    <td>
                        <xsl:value-of select="//tei:author"/>
                    </td>
                </tr>
                <tr>
                    <td>
                        Date
                    </td>
                    <td>
                        <xsl:value-of select="//tei:bibl[@type='firstEdition']/tei:date"/>
                    </td>
                </tr>
                <tr>
                    <td>
                        Publication
                    </td>
                    <td>
                        <xsl:value-of select="//tei:publicationStmt/tei:availability/tei:p"/>
                    </td>
                </tr>
            </table>
        </div>
        </tei>
    </xsl:template>
</xsl:stylesheet>