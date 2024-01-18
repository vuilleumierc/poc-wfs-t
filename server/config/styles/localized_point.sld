<?xml version="1.0" encoding="UTF-8"?>
<StyledLayerDescriptor version="1.0.0"
                      xsi:schemaLocation="http://www.opengis.net/sld StyledLayerDescriptor.xsd"
                      xmlns="http://www.opengis.net/sld"
                      xmlns:ogc="http://www.opengis.net/ogc"
                      xmlns:se="http://www.opengis.net/se"
                      xmlns:xlink="http://www.w3.org/1999/xlink"
                      xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <NamedLayer>
    <Name>localized_point</Name>
    <UserStyle>
      <Name>localized_point</Name>
      <FeatureTypeStyle>
        <Rule>
          <Name>rule1</Name>
            <Title>
            Default rule title
              <Localized lang="en">Title in English</Localized>
              <Localized lang="de">Titel auf Deutsch</Localized>
              <Localized lang="fr">Titre en français</Localized>
              <Localized lang="it">Titolo in italiano</Localized>
            </Title>
          <!-- <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>rule_id</ogc:PropertyName>
              <ogc:Literal>10</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter> -->
          <PointSymbolizer>
            <Graphic>
              <Mark>
                <WellKnownName>circle</WellKnownName>
                <Fill>
                  <CssParameter name="fill">#33cf86</CssParameter>
                </Fill>
              </Mark>
              <Size>10</Size>
            </Graphic>
          </PointSymbolizer>
        </Rule>
      </FeatureTypeStyle>
    </UserStyle>
  </NamedLayer>
</StyledLayerDescriptor>
