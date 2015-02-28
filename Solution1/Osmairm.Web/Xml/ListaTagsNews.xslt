<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">
    <Names>
      <xsl:for-each select="//TipoNews">
        <item>
          <xsl:attribute name="text">
            <xsl:value-of select ="TipoNews_Item/Descrizione_Tipologia"/>
          </xsl:attribute>
          <xsl:attribute name="value">
            <xsl:value-of select ="TipoNews_Item/Id_TipologiaNews"/>
          </xsl:attribute>
        </item>
      </xsl:for-each>
    </Names>
  </xsl:template>
</xsl:stylesheet>
