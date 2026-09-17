[StagingDefinition = [Kind = "FastCopy"]]
section Section1;
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "products_DataDestination", IsNewTarget = true], Settings = [Kind = "Automatic", TypeSettings = [Kind = "Table"]]]}]
shared products = let
  Origine = Csv.Document(Web.Contents("https://raw.githubusercontent.com/MicrosoftLearning/dp-data/refs/heads/main/products.csv"), [Delimiter = ",", Columns = 4, QuoteStyle = QuoteStyle.None]),
  #"Intestazioni alzate di livello" = Table.PromoteHeaders(Origine, [PromoteAllScalars = true]),
  #"Tipo di colonna modificato" = Table.TransformColumnTypes(#"Intestazioni alzate di livello", {{"ProductID", Int64.Type}, {"ProductName", type text}, {"Category", type text}, {"ListPrice", Int64.Type}}, "it")
in
  #"Tipo di colonna modificato";
shared products_DataDestination = let
  Pattern = Lakehouse.Contents([CreateNavigationProperties = false, EnableFolding = false, HierarchicalNavigation = true, EnableVorder = true, OutputMetadataRefresh = true]),
  Navigation_1 = Pattern{[workspaceId = "1889f1eb-4840-4e4e-9f3a-1881cf34d4bd"]}[Data],
  Navigation_2 = Navigation_1{[lakehouseId = "691972c4-ccd1-4c7f-b837-c7ddc004c033"]}[Data],
  Navigation_3 = Navigation_2{[Id = "dbo", ItemKind = "Schema"]}[Data],
  TableNavigation = Navigation_3{[Id = "products", ItemKind = "Table"]}?[Data]?
in
  TableNavigation;
