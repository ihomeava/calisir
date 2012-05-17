<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template match="/">
		<html>
			<head>
				<meta content="text/html; charset=UTF-8" http-equiv="Content-Type"/>
			</head>
			<body>
				<ul>
					<xsl:for-each select="rss/channel/item">
						<li>
							<xsl:element name="a">
								<xsl:attribute name="href"><xsl:value-of
									select="link" /></xsl:attribute>
								<xsl:value-of select="substring(title,0,12)" />...
							</xsl:element>
						</li>
					</xsl:for-each>
				</ul>
			</body>
		</html>
	</xsl:template>

</xsl:stylesheet>