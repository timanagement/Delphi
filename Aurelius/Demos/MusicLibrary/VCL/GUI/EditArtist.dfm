object FrmEditArtist: TFrmEditArtist
  Left = 0
  Top = 0
  Caption = 'Artists'
  ClientHeight = 170
  ClientWidth = 384
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object BevelTop: TBevel
    Left = 0
    Top = 41
    Width = 384
    Height = 2
    Align = alTop
    Shape = bsTopLine
    ExplicitWidth = 542
  end
  object BevelBottom: TBevel
    Left = 0
    Top = 127
    Width = 384
    Height = 2
    Align = alBottom
    Shape = bsBottomLine
    ExplicitTop = 49
    ExplicitWidth = 542
  end
  object PanelTop: TPanel
    Left = 0
    Top = 0
    Width = 384
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Artists'
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 0
  end
  object MainPanel: TPanel
    Left = 0
    Top = 43
    Width = 384
    Height = 84
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      384
      84)
    object lbName: TLabel
      Left = 16
      Top = 13
      Width = 31
      Height = 13
      Caption = 'Name:'
    end
    object lbGenre: TLabel
      Left = 16
      Top = 45
      Width = 33
      Height = 13
      Caption = 'Genre:'
    end
    object edName: TEdit
      Left = 64
      Top = 10
      Width = 308
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
    end
    object edGenre: TEdit
      Left = 64
      Top = 42
      Width = 308
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 1
    end
  end
  object PanelBottom: TPanel
    Left = 0
    Top = 129
    Width = 384
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    DesignSize = (
      384
      41)
    object btSave: TButton
      Left = 190
      Top = 7
      Width = 90
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&Save'
      Default = True
      TabOrder = 0
      OnClick = btSaveClick
    end
    object btCancel: TButton
      Left = 286
      Top = 7
      Width = 90
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&Cancel'
      TabOrder = 1
      OnClick = btCancelClick
    end
  end
end
