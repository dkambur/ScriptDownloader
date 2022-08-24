<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xhtml="http://www.w3.org/1999/xhtml" version="1.0">
    <xsl:output method="text" />
    <xsl:variable name="uploaded" select="'Uploaded: '" />
    <xsl:variable name="by" select="' by '" />
    <xsl:template match="/">
      <xsl:apply-templates select="//xhtml:div[@class='thumbnail']" />
      <xsl:apply-templates select="//xhtml:ul[@class='pagination']/xhtml:li[@class='active']/following-sibling::xhtml:li[1]" />
    </xsl:template>

    <xsl:template match="xhtml:div">
      <!-- xsl:variable name="imgUrl" select="xhtml:a[@target='_blank']/@href" /-->
      <xsl:variable name="imgUrl" select="xhtml:a[@class='lightgallery-item']/@href" />
      <xsl:variable name="comment" select="(xhtml:div[@class='caption']/xhtml:h4 | xhtml:div[@class='caption']/xhtml:p[1])[1]" />
      <xsl:variable name="bits" select="xhtml:div[@class='caption']/xhtml:p[last()-1]" />
      <xsl:variable name="date" select="substring-before(substring-after($bits,$uploaded), $by)" />
      <xsl:variable name="person" select="substring-after($bits, $by)" />

      <xsl:value-of select="translate(concat('LINE|', $imgUrl, '|', $comment, '|', $date, '|', $person), ' &#x9;&#xa;&#xd;', ' ')" /><xsl:text>&#10;</xsl:text>
    </xsl:template>

    <xsl:template match="xhtml:li">
      <xsl:value-of select="concat('LAST|', xhtml:a/@href)" /><xsl:text>&#10;</xsl:text>
    </xsl:template>

</xsl:stylesheet>
