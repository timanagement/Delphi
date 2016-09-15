unit Aurelius.Sql.Firebird;

{$I Aurelius.inc}

interface

uses
  Aurelius.Sql.AnsiSqlGenerator,
  Aurelius.Sql.BaseTypes,
  Aurelius.Sql.Commands,
  Aurelius.Sql.Interfaces,
  Aurelius.Sql.Metadata,
  Aurelius.Sql.Register;

type
  TFirebirdSQLGenerator = class(TAnsiSQLGenerator)
  protected
    function GetMaxConstraintNameLength: Integer; override;
    procedure DefineColumnType(Column: TColumnMetadata); override;

    function GetGeneratorName: string; override;
    function GetSqlDialect: string; override;

    function GenerateGetNextSequenceValue(Command: TGetNextSequenceValueCommand): string; override;
    function GenerateCreateSequence(Sequence: TSequenceMetadata): string; override;
    function GenerateDropSequence(Sequence: TSequenceMetadata): string; override;
    function GenerateLimitedSelect(SelectSql: TSelectSql; Command: TSelectCommand): string; override;

    function GetSupportedFeatures: TDBFeatures; override;
  end;

implementation

uses
  DB, SysUtils;

{ TFirebirdSQLGenerator }

procedure TFirebirdSQLGenerator.DefineColumnType(Column: TColumnMetadata);
begin
  DefineNumericColumnType(Column);
  if Column.DataType <> '' then
    Exit;

  case Column.FieldType of
    ftLargeInt:
      begin
        Column.DataType := 'NUMERIC($pre)';
        Column.Precision := 18;
      end;

    ftWideString:
      Column.DataType := 'NCHAR VARYING($len)';

    ftCurrency:
      begin
        Column.DataType := 'NUMERIC($pre, $sca)';
        Column.Precision := 18;
        Column.Scale := 4;
      end;
//    ftFMTBcd:
//      Column.DataType := 'NUMERIC(18, 9)';

    ftMemo:
      Column.DataType := 'BLOB SUB_TYPE TEXT';
    ftWideMemo:
      Column.DataType := 'BLOB SUB_TYPE TEXT';
    ftBlob:
      Column.DataType := 'BLOB';
  else
    inherited DefineColumnType(Column);
  end;
end;

function TFirebirdSQLGenerator.GenerateCreateSequence(Sequence: TSequenceMetadata): string;
begin
  Result := 'CREATE GENERATOR ' + Sequence.Name + ';';
end;

function TFirebirdSQLGenerator.GenerateDropSequence(Sequence: TSequenceMetadata): string;
begin
  Result := 'DROP GENERATOR ' + Sequence.Name + ';';
end;

function TFirebirdSQLGenerator.GenerateGetNextSequenceValue(
  Command: TGetNextSequenceValueCommand): string;
begin
  Result := 'SELECT GEN_ID(' + Command.SequenceName + ', ' +
    IntToStr(Command.Increment) + ')'#13#10'FROM RDB$DATABASE;';
end;

function TFirebirdSQLGenerator.GenerateLimitedSelect(SelectSql: TSelectSql; Command: TSelectCommand): string;
begin
  Result := GenerateRegularSelect(SelectSql) + #13#10;
  if Command.HasFirstRow then
    Result := Result + Format('ROWS %d To %d', [Command.FirstRow + 1, Command.LastRow + 1])
  else
    Result := Result + Format('ROWS %d', [Command.MaxRows]);
end;

function TFirebirdSQLGenerator.GetSqlDialect: string;
begin
  Result := 'Firebird';
end;

function TFirebirdSQLGenerator.GetGeneratorName: string;
begin
  Result := 'Firebird SQL Generator';
end;

function TFirebirdSQLGenerator.GetMaxConstraintNameLength: Integer;
begin
  Result := 31;
end;

function TFirebirdSQLGenerator.GetSupportedFeatures: TDBFeatures;
begin
  Result := AllDBFeatures - [TDBFeature.AutoGenerated];
end;

initialization
  TSQLGeneratorRegister.GetInstance.RegisterGenerator(TFirebirdSQLGenerator.Create);

end.
