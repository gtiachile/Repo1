USE [master]
GO
/****** Object:  Database [BopDB]    Script Date: 29-10-2015 22:30:16 ******/
CREATE DATABASE [BopDB] ON  PRIMARY 
( NAME = N'BopDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\BopDB.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'BopDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\BopDB_log.ldf' , SIZE = 4096KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BopDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BopDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [BopDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [BopDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [BopDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [BopDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [BopDB] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [BopDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [BopDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [BopDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [BopDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [BopDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [BopDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [BopDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [BopDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [BopDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [BopDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [BopDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [BopDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [BopDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [BopDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [BopDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [BopDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [BopDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [BopDB] SET  MULTI_USER 
GO
ALTER DATABASE [BopDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [BopDB] SET DB_CHAINING OFF 
GO
USE [BopDB]
GO
/****** Object:  User [BopUsr]    Script Date: 29-10-2015 22:30:16 ******/
CREATE USER [BopUsr] FOR LOGIN [BopUsr] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [admin]    Script Date: 29-10-2015 22:30:16 ******/
CREATE USER [admin] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  UserDefinedFunction [dbo].[f_avanceOF]    Script Date: 29-10-2015 22:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[f_avanceOF] 
(
	-- Add the parameters for the function here
	@OF varchar(15)
)
RETURNS numeric 
AS
BEGIN
	-- Declare the return variable here
	DECLARE @avance numeric(10,1)
	DECLARE @real int
	SET @avance = 0
	SELECT @real = CantidadReal from OrdenesFabricacion where OrdenFab = @OF
	IF isNull(@real,0) <> 0
		SELECT        @avance = isNull(CantidadReal,0)*100/isNull(CantidadPlanif,0)
		FROM OrdenesFabricacion
		WHERE OrdenFab = @OF
	RETURN @avance

END





GO
/****** Object:  UserDefinedFunction [dbo].[f_duracionOF]    Script Date: 29-10-2015 22:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[f_duracionOF] 
(
	-- Add the parameters for the function here
	@material nchar(50),
	@cantidad numeric(10,1)
)
RETURNS nchar(10)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @duracion numeric(10,1)
	DECLARE @resultado nchar(10)

	SELECT        @duracion = (@cantidad / Formatos.Rendimiento)
	FROM            Productos INNER JOIN
		                     Formatos ON RTrim(Productos.Formato) = Rtrim(Formatos.Formato)
	WHERE        (RTrim(Productos.Material) = @material)
	SET @duracion = ISNULL(@duracion,0)
	SET @resultado = Cast(@duracion as nchar(15))
	RETURN @resultado

END



GO
/****** Object:  UserDefinedFunction [dbo].[f_lote_OF]    Script Date: 29-10-2015 22:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[f_lote_OF] 
(
	-- Add the parameters for the function here
	@OrdenFab varchar(15)
)
RETURNS int
AS
BEGIN
	-- Declare the return variable here
	DECLARE @lote int

	SELECT        @lote = max(Lote)
	FROM          Notificaciones
	WHERE        (OrdenFab = @OrdenFab)
	SET @lote = isNull(@lote,0) + 1

	RETURN @lote

END




GO
/****** Object:  UserDefinedFunction [dbo].[f_MinInicioFin]    Script Date: 29-10-2015 22:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE function [dbo].[f_MinInicioFin]
(
@inicio varchar(5),
@fin varchar(5)
)
RETURNS INT
as
BEGIN
DECLARE @minutos int
DECLARE @shh_ini varchar(2)
DECLARE @shh_fin varchar(2)
DECLARE @smm_ini varchar(2)
DECLARE @smm_fin varchar(2)
DECLARE @nhh_ini int
DECLARE @nhh_fin int
DECLARE @nmm_ini int
DECLARE @nmm_fin int

SET @shh_ini = substring(@inicio,1,2)
SET @shh_fin = substring(@fin,1,2)
SET @smm_ini = substring(@inicio,4,2)
SET @smm_fin = substring(@fin,4,2)
SET @nhh_ini =  @shh_ini
SET @nhh_fin =  @shh_fin
SET @nmm_ini =  @smm_ini
SET @nmm_fin =  @smm_fin

SET @minutos = datediff(MINUTE,TIMEFROMPARTS(@nhh_ini,@nmm_ini,0,0,0),TIMEFROMPARTS(@nhh_fin,@nmm_fin,0,0,0))

RETURN @minutos
END


GO
/****** Object:  UserDefinedFunction [dbo].[f_nueva_linea_planilla]    Script Date: 29-10-2015 22:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[f_nueva_linea_planilla] 
(
	-- Add the parameters for the function here
	@NroPlanilla bigint
)
RETURNS int
AS
BEGIN
	-- Declare the return variable here
	DECLARE @n int

	SELECT        @n = max(Linea)
	FROM          PlanillasMedicionDet
	WHERE        (NroPlanilla = @NroPlanilla)
	SET @n = isNull(@n,0) + 1

	RETURN @n

END





GO
/****** Object:  UserDefinedFunction [dbo].[f_secuencia_detencion]    Script Date: 29-10-2015 22:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[f_secuencia_detencion]
(

)
RETURNs bigint
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result bigint
	SELECT @Result=actual from secuencias where tipo='DETEN'
	RETURN @Result
END



GO
/****** Object:  UserDefinedFunction [dbo].[f_secuencia_incidente]    Script Date: 29-10-2015 22:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[f_secuencia_incidente]
(

)
RETURNs bigint
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result bigint
	SELECT @Result=actual from secuencias where tipo='INCID'
	RETURN @Result
END




GO
/****** Object:  UserDefinedFunction [dbo].[f_secuencia_OF]    Script Date: 29-10-2015 22:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[f_secuencia_OF]
(

)
RETURNs bigint
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result bigint
	SELECT @Result=actual from secuencias where tipo='OF'
	RETURN @Result
END


GO
/****** Object:  UserDefinedFunction [dbo].[f_secuencia_PLANILLA]    Script Date: 29-10-2015 22:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[f_secuencia_PLANILLA]
(

)
RETURNs bigint
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result bigint
	SELECT @Result=actual from secuencias where tipo='PLANI'
	RETURN @Result
END



GO
/****** Object:  Table [dbo].[Areas]    Script Date: 29-10-2015 22:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Areas](
	[Area] [varchar](10) NOT NULL,
	[Descripción] [varchar](20) NOT NULL,
	[Fecha Creación] [varchar](20) NULL,
	[Estado] [varchar](10) NOT NULL,
	[Planta] [varchar](10) NOT NULL,
	[CCosto] [varchar](10) NOT NULL DEFAULT ('CSJP00111'),
 CONSTRAINT [PK_Areas] PRIMARY KEY CLUSTERED 
(
	[Area] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Autorizaciones]    Script Date: 29-10-2015 22:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Autorizaciones](
	[Perfil] [varchar](15) NOT NULL,
	[Modulo] [varchar](15) NOT NULL,
	[Opcion] [varchar](20) NOT NULL,
	[Estado] [varchar](10) NOT NULL,
	[Fecha Creación] [varchar](20) NULL,
	[Fecha Modif] [varchar](20) NULL,
	[Usuario Modif] [varchar](10) NULL,
 CONSTRAINT [PK_Autorizaciones] PRIMARY KEY CLUSTERED 
(
	[Perfil] ASC,
	[Modulo] ASC,
	[Opcion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CausasDetencion]    Script Date: 29-10-2015 22:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CausasDetencion](
	[Causa] [varchar](4) NOT NULL,
	[Descripción] [varchar](50) NOT NULL,
	[Tipo] [varchar](2) NOT NULL,
	[Planificada] [varchar](2) NOT NULL,
	[Estandar] [varchar](2) NOT NULL,
	[Mantencion] [varchar](2) NOT NULL,
	[Fecha Creación] [varchar](20) NULL,
	[Estado] [varchar](10) NOT NULL,
 CONSTRAINT [PK_CausasDetencion] PRIMARY KEY CLUSTERED 
(
	[Causa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Centros]    Script Date: 29-10-2015 22:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Centros](
	[Centro] [varchar](10) NOT NULL,
	[Descripción] [varchar](15) NOT NULL,
	[Dirección] [varchar](30) NOT NULL,
	[Fecha Creación] [date] NULL,
	[Estado] [varchar](10) NOT NULL,
 CONSTRAINT [PK_Centros] PRIMARY KEY CLUSTERED 
(
	[Centro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Detenciones]    Script Date: 29-10-2015 22:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Detenciones](
	[NroDetencion] [bigint] NOT NULL,
	[Equipo] [varchar](10) NOT NULL,
	[CodigoCausaPrimario] [varchar](4) NOT NULL,
	[CodigoCausaSecundario] [varchar](10) NULL,
	[FechaDetencion] [varchar](20) NOT NULL,
	[InicioDetencion] [varchar](5) NOT NULL,
	[FinDetencion] [varchar](5) NOT NULL,
	[Observaciones] [nvarchar](300) NULL,
	[Usuario] [varchar](50) NOT NULL,
	[FechaGrabacion] [datetime] NULL,
 CONSTRAINT [PK_Detenciones] PRIMARY KEY CLUSTERED 
(
	[NroDetencion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Equipos]    Script Date: 29-10-2015 22:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Equipos](
	[Equipo] [varchar](10) NOT NULL,
	[Descripción] [varchar](30) NOT NULL,
	[Proceso] [varchar](10) NOT NULL,
	[Fecha Creación] [varchar](20) NULL,
	[Estado] [varchar](10) NOT NULL,
 CONSTRAINT [PK_Equipos] PRIMARY KEY CLUSTERED 
(
	[Equipo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Estados]    Script Date: 29-10-2015 22:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Estados](
	[Estado] [varchar](10) NOT NULL,
 CONSTRAINT [PK_Estados] PRIMARY KEY CLUSTERED 
(
	[Estado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FamiliaProductos]    Script Date: 29-10-2015 22:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FamiliaProductos](
	[Codigo] [varchar](2) NOT NULL,
	[FamiliaProducto] [varchar](20) NOT NULL,
	[Estado] [varchar](10) NOT NULL,
 CONSTRAINT [PK_FamiliaProductos] PRIMARY KEY CLUSTERED 
(
	[Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Formatos]    Script Date: 29-10-2015 22:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Formatos](
	[Formato] [varchar](10) NOT NULL,
	[CodigoFamilia] [varchar](2) NOT NULL,
	[Rendimiento] [numeric](10, 6) NOT NULL,
	[Fecha Creación] [varchar](20) NULL,
	[Estado] [varchar](10) NOT NULL,
 CONSTRAINT [PK_Formatos] PRIMARY KEY CLUSTERED 
(
	[Formato] ASC,
	[CodigoFamilia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GanttDependencies]    Script Date: 29-10-2015 22:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GanttDependencies](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[PredecessorID] [int] NOT NULL,
	[SuccessorID] [int] NOT NULL,
	[Type] [int] NOT NULL,
 CONSTRAINT [PK_GanttDependencies] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[GanttResourceAssignments]    Script Date: 29-10-2015 22:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GanttResourceAssignments](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TaskID] [int] NOT NULL,
	[ResourceID] [int] NOT NULL,
	[Units] [decimal](5, 2) NOT NULL,
 CONSTRAINT [PK_GanttResourceAssignments] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[GanttResources]    Script Date: 29-10-2015 22:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GanttResources](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Color] [varchar](10) NULL,
 CONSTRAINT [PK_GanttResources] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GanttTasks]    Script Date: 29-10-2015 22:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GanttTasks](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ParentID] [int] NULL,
	[OrderID] [int] NOT NULL,
	[Title] [nvarchar](max) NULL,
	[Start] [datetime] NOT NULL,
	[End] [datetime] NOT NULL,
	[PercentComplete] [decimal](5, 2) NOT NULL,
	[Expanded] [bit] NULL,
	[Summary] [bit] NOT NULL,
	[Description] [nvarchar](50) NULL,
 CONSTRAINT [PK_GanttTasks] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Incidentes]    Script Date: 29-10-2015 22:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Incidentes](
	[Incidente] [bigint] NOT NULL,
	[TipoIncidente] [varchar](10) NOT NULL,
	[FechaIncidente] [varchar](20) NOT NULL,
	[HoraIncidente] [varchar](5) NOT NULL,
	[Planta] [varchar](10) NOT NULL,
	[Area] [varchar](10) NULL,
	[Proceso] [varchar](10) NULL,
	[Equipo] [varchar](10) NULL,
	[Usuario] [varchar](50) NOT NULL,
	[Asunto] [varchar](300) NOT NULL,
	[Descripcion] [varchar](2000) NOT NULL,
	[IndAlerta] [varchar](2) NOT NULL,
 CONSTRAINT [PK_Incidentes] PRIMARY KEY CLUSTERED 
(
	[Incidente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Marcas]    Script Date: 29-10-2015 22:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Marcas](
	[Codigo] [varchar](2) NOT NULL,
	[Marca] [varchar](15) NOT NULL,
	[Estado] [varchar](10) NOT NULL,
 CONSTRAINT [PK_Marcas] PRIMARY KEY CLUSTERED 
(
	[Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Menu_N0]    Script Date: 29-10-2015 22:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Menu_N0](
	[Perfil] [varchar](15) NOT NULL,
	[Posicion] [int] NOT NULL,
	[Modulo] [varchar](15) NOT NULL,
 CONSTRAINT [PK_Menu_N0] PRIMARY KEY CLUSTERED 
(
	[Perfil] ASC,
	[Posicion] ASC,
	[Modulo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Menu_N1]    Script Date: 29-10-2015 22:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Menu_N1](
	[Perfil] [varchar](15) NOT NULL,
	[Modulo] [varchar](15) NOT NULL,
	[Posicion] [int] NOT NULL,
	[Opcion] [varchar](15) NOT NULL,
 CONSTRAINT [PK_Menu_N1] PRIMARY KEY CLUSTERED 
(
	[Perfil] ASC,
	[Modulo] ASC,
	[Posicion] ASC,
	[Opcion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Menu_N2]    Script Date: 29-10-2015 22:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Menu_N2](
	[Perfil] [varchar](15) NOT NULL,
	[Modulo] [varchar](15) NOT NULL,
	[Posicion] [int] NOT NULL,
	[Opcion1] [varchar](15) NOT NULL,
	[Opcion2] [varchar](15) NOT NULL,
 CONSTRAINT [PK_Menu_N2] PRIMARY KEY CLUSTERED 
(
	[Perfil] ASC,
	[Modulo] ASC,
	[Posicion] ASC,
	[Opcion1] ASC,
	[Opcion2] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Modulos]    Script Date: 29-10-2015 22:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Modulos](
	[Modulo] [varchar](15) NOT NULL,
	[Descripción] [varchar](30) NOT NULL,
	[Estado] [varchar](10) NOT NULL,
 CONSTRAINT [PK_Modulos] PRIMARY KEY CLUSTERED 
(
	[Modulo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Notificaciones]    Script Date: 29-10-2015 22:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Notificaciones](
	[OrdenFab] [varchar](15) NOT NULL,
	[Lote] [int] NOT NULL,
	[LoteSAP] [varchar](50) NULL,
	[Equipo] [varchar](10) NOT NULL,
	[Inicio] [varchar](5) NOT NULL,
	[Fin] [varchar](5) NULL,
	[Usuario] [varchar](50) NOT NULL,
	[FechaModificacion] [varchar](20) NOT NULL,
	[Producción] [numeric](18, 0) NULL,
	[Rechazo] [numeric](18, 0) NULL,
	[CausaRechazo] [varchar](10) NULL,
 CONSTRAINT [PK_Notificaciones] PRIMARY KEY CLUSTERED 
(
	[OrdenFab] ASC,
	[Lote] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Opciones]    Script Date: 29-10-2015 22:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Opciones](
	[Opcion] [varchar](20) NOT NULL,
	[Descripción] [varchar](30) NOT NULL,
	[Modulo] [varchar](15) NOT NULL,
	[Estado] [varchar](10) NOT NULL,
	[tipo] [varchar](10) NOT NULL DEFAULT ('Pagina'),
	[url] [varchar](100) NULL,
	[tx] [varchar](20) NULL,
 CONSTRAINT [PK_Opciones] PRIMARY KEY CLUSTERED 
(
	[Opcion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[OrdenesFabricacion]    Script Date: 29-10-2015 22:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[OrdenesFabricacion](
	[OrdenFab] [varchar](15) NOT NULL,
	[FechaPlanif] [varchar](20) NOT NULL,
	[Area] [varchar](10) NOT NULL,
	[Turno] [varchar](10) NOT NULL,
	[Material] [varchar](10) NOT NULL,
	[CantidadPlanif] [int] NOT NULL,
	[TiempoPlanif] [numeric](10, 1) NULL,
	[CantidadReal] [int] NULL,
	[TiempoReal] [numeric](10, 1) NULL,
	[Inicio] [varchar](5) NULL,
	[Fin] [varchar](5) NULL,
	[Prioridad] [varchar](10) NULL,
	[Fecha Lote] [varchar](20) NULL,
	[Observaciones] [varchar](100) NULL,
	[Planificador] [varchar](50) NULL,
	[Fecha Creación] [varchar](20) NULL,
	[Fecha Modif] [varchar](20) NULL,
	[EstadoOF] [varchar](10) NULL,
 CONSTRAINT [PK_OrdenesFabricacion] PRIMARY KEY CLUSTERED 
(
	[OrdenFab] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Perfiles]    Script Date: 29-10-2015 22:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[Perfiles](
	[Perfil] [varchar](15) NOT NULL,
	[Descripción] [varchar](30) NOT NULL,
	[Estado] [varchar](10) NOT NULL,
 CONSTRAINT [PK_Perfiles] PRIMARY KEY CLUSTERED 
(
	[Perfil] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PlanillasMedicionDet]    Script Date: 29-10-2015 22:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PlanillasMedicionDet](
	[NroPlanilla] [bigint] NOT NULL,
	[Linea] [int] NOT NULL,
	[Variable] [varchar](10) NULL,
	[Obligatorio] [bit] NULL,
	[Lote] [bit] NULL,
	[Producto] [bit] NULL,
 CONSTRAINT [PK_PlanillasMedicionDet] PRIMARY KEY CLUSTERED 
(
	[NroPlanilla] ASC,
	[Linea] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PlanillasMedicionEnc]    Script Date: 29-10-2015 22:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PlanillasMedicionEnc](
	[NroPlanilla] [bigint] NOT NULL,
	[Titulo] [varchar](100) NOT NULL,
	[Planta] [varchar](10) NULL,
	[Area] [varchar](10) NULL,
	[Proceso] [varchar](10) NULL,
	[Equipo] [varchar](30) NULL,
	[DiasToleranciaIng] [int] NOT NULL,
	[Estado] [varchar](10) NOT NULL,
 CONSTRAINT [PK_PlanillasMedicionEnc] PRIMARY KEY CLUSTERED 
(
	[NroPlanilla] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Plantas]    Script Date: 29-10-2015 22:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[Plantas](
	[Planta] [varchar](10) NOT NULL,
	[Descripción] [varchar](20) NOT NULL,
	[Fecha Creación] [varchar](20) NULL,
	[Estado] [varchar](10) NOT NULL,
	[Centro] [varchar](10) NOT NULL,
 CONSTRAINT [PK_Plantas] PRIMARY KEY CLUSTERED 
(
	[Planta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Procesos]    Script Date: 29-10-2015 22:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[Procesos](
	[Proceso] [varchar](10) NOT NULL,
	[Descripción] [varchar](20) NOT NULL,
	[Fecha Creación] [varchar](20) NULL,
	[Estado] [varchar](10) NOT NULL,
	[Area] [varchar](10) NOT NULL,
 CONSTRAINT [PK_Procesos] PRIMARY KEY CLUSTERED 
(
	[Proceso] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Productos]    Script Date: 29-10-2015 22:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[Productos](
	[Material] [varchar](10) NOT NULL,
	[Producto] [varchar](50) NOT NULL,
	[CodigoMarca] [varchar](2) NOT NULL,
	[Planta] [varchar](10) NOT NULL,
	[Proceso] [varchar](10) NOT NULL,
	[CodigoFamilia] [varchar](2) NOT NULL,
	[IndSemielaborado] [varchar](2) NOT NULL,
	[PesoNeto] [numeric](10, 5) NULL,
	[PesoNetoCaja] [numeric](10, 5) NULL,
	[Estado] [varchar](10) NOT NULL,
	[Unidad] [varchar](5) NOT NULL DEFAULT ('Kg'),
	[Formato] [varchar](10) NOT NULL DEFAULT ('MANUAL'),
 CONSTRAINT [PK_Productos] PRIMARY KEY CLUSTERED 
(
	[Material] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Secuencias]    Script Date: 29-10-2015 22:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Secuencias](
	[tipo] [varchar](10) NOT NULL,
	[inicial] [bigint] NOT NULL,
	[actual] [bigint] NOT NULL,
	[incremento] [int] NOT NULL,
	[fechaUltAct] [datetime] NULL,
 CONSTRAINT [PK_Secuencias] PRIMARY KEY CLUSTERED 
(
	[tipo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TipoDetencion]    Script Date: 29-10-2015 22:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TipoDetencion](
	[Tipo] [varchar](2) NOT NULL,
	[Descripción] [varchar](20) NOT NULL,
	[Estado] [varchar](10) NOT NULL,
 CONSTRAINT [PK_TipoDetencion] PRIMARY KEY CLUSTERED 
(
	[Tipo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TiposIncidentes]    Script Date: 29-10-2015 22:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TiposIncidentes](
	[TipoInicidente] [varchar](10) NOT NULL,
	[Descripcion] [varchar](50) NOT NULL,
	[Estado] [varchar](10) NOT NULL,
	[emailAlerta] [varchar](100) NULL,
 CONSTRAINT [PK_TiposIncidentes] PRIMARY KEY CLUSTERED 
(
	[TipoInicidente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TurnoPlanta]    Script Date: 29-10-2015 22:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TurnoPlanta](
	[Codigo] [varchar](10) NOT NULL,
	[Descripción] [varchar](30) NOT NULL,
	[Planta] [varchar](10) NOT NULL,
	[Turno] [varchar](10) NOT NULL,
	[HoraInicio] [varchar](5) NOT NULL,
	[HoraFin] [varchar](5) NOT NULL,
	[DotacionStd] [int] NULL,
	[Fecha Creación] [varchar](20) NULL,
	[Estado] [varchar](10) NOT NULL,
 CONSTRAINT [PK_TurnoPlanta] PRIMARY KEY CLUSTERED 
(
	[Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Turnos]    Script Date: 29-10-2015 22:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[Turnos](
	[Turno] [varchar](10) NOT NULL,
 CONSTRAINT [PK_Turnos] PRIMARY KEY CLUSTERED 
(
	[Turno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Unidades]    Script Date: 29-10-2015 22:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[Unidades](
	[Unidad] [varchar](5) NOT NULL,
	[Descripcion] [varchar](15) NOT NULL,
	[Fecha Creación] [varchar](20) NULL,
	[Estado] [varchar](10) NOT NULL
) ON [PRIMARY]
SET ANSI_PADDING ON
ALTER TABLE [dbo].[Unidades] ADD [Tipo] [varchar](10) NOT NULL DEFAULT ('Producto')
 CONSTRAINT [PK_Unidades] PRIMARY KEY CLUSTERED 
(
	[Unidad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UsuarioFuncion]    Script Date: 29-10-2015 22:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UsuarioFuncion](
	[Usuario] [varchar](50) NOT NULL,
	[Funcion] [varchar](50) NOT NULL,
	[Area] [varchar](10) NOT NULL,
	[Turno] [varchar](10) NOT NULL,
	[Proceso] [varchar](10) NULL,
	[Equipo] [varchar](10) NULL,
	[NivelRegDetencion] [varchar](10) NULL,
	[DiasAtrasoReg] [int] NOT NULL DEFAULT ((0)),
 CONSTRAINT [PK_UsuarioFuncion] PRIMARY KEY CLUSTERED 
(
	[Usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Usuarios]    Script Date: 29-10-2015 22:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[Usuarios](
	[Usuario] [varchar](50) NOT NULL,
	[Nombre] [varchar](30) NOT NULL,
	[eMail] [varchar](40) NOT NULL,
	[Pass] [varchar](10) NOT NULL,
	[Fecha Creación] [varchar](20) NULL,
	[Estado] [varchar](10) NOT NULL,
	[UsuarioAD] [varchar](50) NULL,
	[DominioAD] [varchar](20) NULL,
	[Perfil] [varchar](15) NULL,
	[Expiracion] [varchar](20) NULL,
 CONSTRAINT [PK_Usuarios] PRIMARY KEY CLUSTERED 
(
	[Usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Variables]    Script Date: 29-10-2015 22:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Variables](
	[Variable] [varchar](10) NOT NULL,
	[Equipo] [varchar](30) NOT NULL,
	[Descripcion] [varchar](50) NOT NULL,
	[Unidad] [varchar](5) NOT NULL,
	[LimSup] [numeric](18, 4) NULL,
	[LimInf] [numeric](18, 4) NULL,
	[Fecha Creación] [varchar](20) NULL,
	[Estado] [varchar](10) NOT NULL,
 CONSTRAINT [PK_Variables] PRIMARY KEY CLUSTERED 
(
	[Variable] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [dbo].[V_LAYOUT_TREE_N0]    Script Date: 29-10-2015 22:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Script for SelectTopNRows command from SSMS  ******/
CREATE VIEW [dbo].[V_LAYOUT_TREE_N0]
AS
SELECT [Descripción] as NODE_DESCRIPTION,
	   ROW_NUMBER() OVER(ORDER BY Planta) as NODE_ID,
	   0 UNDER_PARENT,
	   0 LEVEL_DEPTH,
	   [Planta] as Codigo
  FROM [BopDB].[dbo].[Plantas]
  WHERE Estado='Activo'


GO
/****** Object:  View [dbo].[V_MENUS]    Script Date: 29-10-2015 22:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE view [dbo].[V_MENUS] as
SELECT        Perfil, CAST(Posicion AS nchar(1)) AS MenuID, Modulo AS MenuName, 0 AS ParentID, NULL AS MenuLocation, Modulo AS Text, NULL AS NavigateUrl
FROM            Menu_N0
union
SELECT        Menu_N1.Perfil, CAST(CAST(Menu_N0.Posicion AS nchar(1)) + CAST(Menu_N1.Posicion AS nchar(1)) AS int) AS MenuId, Menu_N1.Opcion AS MenuName, CAST(Menu_N0.Posicion AS int) AS ParentID, NULL 
                         AS MenuLocation, Opciones.Descripción AS Text, '~' + Opciones.url AS NavigateUrl
FROM            Menu_N1 INNER JOIN
                         Menu_N0 ON Menu_N1.Perfil = Menu_N0.Perfil AND Menu_N1.Modulo = Menu_N0.Modulo INNER JOIN
                         Opciones ON Menu_N1.Opcion = Opciones.Opcion
union
SELECT        Menu_N2.Perfil, CAST(CAST(Menu_N0.Posicion AS nchar(1)) + CAST(Menu_N1.Posicion AS nchar(1)) + CAST(Menu_N2.Posicion AS nchar(1)) AS int) AS MenuID, Menu_N2.Opcion2 AS MenuName,
                          CAST(CAST(Menu_N0.Posicion AS nchar(1)) + CAST(Menu_N1.Posicion AS nchar(1)) AS int) AS ParentID, NULL AS MenuLocation, Opciones.Descripción AS Text, '~'+ Opciones.url AS NavigateUrl
FROM            Menu_N2 INNER JOIN
                         Menu_N1 ON Menu_N2.Perfil = Menu_N1.Perfil AND Menu_N2.Modulo = Menu_N1.Modulo AND Menu_N2.Opcion1 = Menu_N1.Opcion INNER JOIN
                         Menu_N0 ON Menu_N1.Perfil = Menu_N0.Perfil AND Menu_N1.Modulo = Menu_N0.Modulo INNER JOIN
                         Opciones ON Menu_N2.Opcion2 = Opciones.Opcion AND Menu_N2.Modulo = Opciones.Modulo






GO
/****** Object:  View [dbo].[v_PlanProduccion]    Script Date: 29-10-2015 22:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[v_PlanProduccion] as
SELECT        Areas.Planta,OrdenesFabricacion.FechaPlanif AS Fecha, Areas.Descripción AS Area, OrdenesFabricacion.Material + ' - ' + Productos.Producto AS Producto, Productos.Unidad, 
                         CASE TurnoPlanta.Descripción WHEN 'Turno Día' THEN SUM(OrdenesFabricacion.CantidadPlanif) END AS QDia, CASE TurnoPlanta.Descripción WHEN 'Turno Tarde' THEN SUM(OrdenesFabricacion.CantidadPlanif)
                          END AS QTarde, CASE TurnoPlanta.Descripción WHEN 'Turno Noche' THEN SUM(OrdenesFabricacion.CantidadPlanif) END AS QNoche, 
                         CASE TurnoPlanta.Descripción WHEN 'Turno Día' THEN SUM(OrdenesFabricacion.TiempoPlanif) END AS tDia, CASE TurnoPlanta.Descripción WHEN 'Turno Tarde' THEN SUM(OrdenesFabricacion.TiempoPlanif) 
                         END AS tTarde, CASE TurnoPlanta.Descripción WHEN 'Turno Noche' THEN SUM(OrdenesFabricacion.TiempoPlanif) END AS tNoche, Productos.Formato
FROM            OrdenesFabricacion INNER JOIN
                         Areas ON OrdenesFabricacion.Area = Areas.Area INNER JOIN
                         Productos ON OrdenesFabricacion.Material = Productos.Material INNER JOIN
                         TurnoPlanta ON Areas.Planta = TurnoPlanta.Planta AND OrdenesFabricacion.Turno = TurnoPlanta.Codigo
GROUP BY OrdenesFabricacion.FechaPlanif, Areas.Descripción, OrdenesFabricacion.Material + ' - ' + Productos.Producto, Productos.Unidad, TurnoPlanta.Descripción, Productos.Formato, Areas.Planta




GO
/****** Object:  View [dbo].[v_reporte_detenciones]    Script Date: 29-10-2015 22:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Script for SelectTopNRows command from SSMS  ******/
CREATE VIEW [dbo].[v_reporte_detenciones]
as
SELECT        Detenciones.NroDetencion, Detenciones.Equipo, Detenciones.CodigoCausaPrimario, Detenciones.CodigoCausaSecundario, Convert(datetime,Detenciones.FechaDetencion,105) as FechaDetencion, Detenciones.InicioDetencion, Detenciones.FinDetencion, 
						 dbo.f_MinInicioFin(Detenciones.InicioDetencion,Detenciones.FinDetencion) as duracion,
                         Detenciones.Observaciones, Detenciones.Usuario, Detenciones.FechaGrabacion, Equipos.Descripción, Procesos.Proceso, Procesos.Descripción AS DescProcesos, Areas.Area, Areas.Descripción AS DescArea, 
                         Plantas.Planta, Plantas.Descripción AS Descplanta, CausasDetencion.Causa AS CodCausaPri, CausasDetencion_1.Causa AS CodCausaSec, CausasDetencion.Descripción AS DescCausaPri, 
                         CausasDetencion_1.Descripción AS DescCausaSec
FROM            Detenciones INNER JOIN
                         Equipos ON Detenciones.Equipo = Equipos.Equipo INNER JOIN
                         Procesos ON Equipos.Proceso = Procesos.Proceso INNER JOIN
                         Areas ON Procesos.Area = Areas.Area INNER JOIN
                         Plantas ON Areas.Planta = Plantas.Planta INNER JOIN
                         CausasDetencion ON Detenciones.CodigoCausaPrimario = CausasDetencion.Causa LEFT OUTER JOIN
                         CausasDetencion AS CausasDetencion_1 ON Detenciones.CodigoCausaSecundario = CausasDetencion_1.Causa

GO
/****** Object:  View [dbo].[v_reporte_incidentes]    Script Date: 29-10-2015 22:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [dbo].[v_reporte_incidentes] as
SELECT        Incidentes.Incidente, TiposIncidentes.Descripcion AS DescTipoIncidente, Convert(datetime,Incidentes.FechaIncidente,105) as FechaIncidente, Incidentes.HoraIncidente, Incidentes.Planta, Plantas.Descripción AS DescPlanta, Incidentes.Area, 
                         ISNULL(Areas.Descripción, '') AS DescArea, Incidentes.Proceso, ISNULL(Procesos.Descripción, '') AS DescProceso, Incidentes.Equipo, ISNULL(Equipos.Descripción, '') AS DescEquipo, Incidentes.Usuario, 
                         Incidentes.Asunto, Incidentes.Descripcion, Incidentes.IndAlerta
FROM            Equipos RIGHT OUTER JOIN
                         Incidentes INNER JOIN
                         TiposIncidentes ON Incidentes.TipoIncidente = TiposIncidentes.TipoInicidente LEFT OUTER JOIN
                         Plantas ON Incidentes.Planta = Plantas.Planta ON Equipos.Equipo = Incidentes.Equipo LEFT OUTER JOIN
                         Procesos ON Incidentes.Proceso = Procesos.Proceso LEFT OUTER JOIN
                         Areas ON Incidentes.Area = Areas.Area

GO
INSERT [dbo].[Areas] ([Area], [Descripción], [Fecha Creación], [Estado], [Planta], [CCosto]) VALUES (N'VIE01', N'Preparación Pasta', N'Aug 26 2015  2:30PM', N'Activo', N'VIE', N'CSJP00111')
INSERT [dbo].[Areas] ([Area], [Descripción], [Fecha Creación], [Estado], [Planta], [CCosto]) VALUES (N'VIE02', N'Embutido y Cocción', N'Aug 26 2015  2:30PM', N'Activo', N'VIE', N'CSJP00111')
INSERT [dbo].[Areas] ([Area], [Descripción], [Fecha Creación], [Estado], [Planta], [CCosto]) VALUES (N'VIE03', N'Envasado', N'Aug 26 2015  2:31PM', N'Activo', N'VIE', N'CSJP00111')
INSERT [dbo].[Autorizaciones] ([Perfil], [Modulo], [Opcion], [Estado], [Fecha Creación], [Fecha Modif], [Usuario Modif]) VALUES (N'Administrador', N'Admin', N'Autorizaciones', N'Activo', NULL, NULL, NULL)
INSERT [dbo].[Autorizaciones] ([Perfil], [Modulo], [Opcion], [Estado], [Fecha Creación], [Fecha Modif], [Usuario Modif]) VALUES (N'Administrador', N'Admin', N'Menus', N'Activo', NULL, NULL, NULL)
INSERT [dbo].[Autorizaciones] ([Perfil], [Modulo], [Opcion], [Estado], [Fecha Creación], [Fecha Modif], [Usuario Modif]) VALUES (N'Administrador', N'Admin', N'Módulos', N'Activo', NULL, NULL, NULL)
INSERT [dbo].[Autorizaciones] ([Perfil], [Modulo], [Opcion], [Estado], [Fecha Creación], [Fecha Modif], [Usuario Modif]) VALUES (N'Administrador', N'Admin', N'Opciones', N'Activo', NULL, NULL, NULL)
INSERT [dbo].[Autorizaciones] ([Perfil], [Modulo], [Opcion], [Estado], [Fecha Creación], [Fecha Modif], [Usuario Modif]) VALUES (N'Administrador', N'Admin', N'Perfiles', N'Activo', NULL, NULL, NULL)
INSERT [dbo].[Autorizaciones] ([Perfil], [Modulo], [Opcion], [Estado], [Fecha Creación], [Fecha Modif], [Usuario Modif]) VALUES (N'Administrador', N'Admin', N'Usuario Fn', N'Activo', NULL, NULL, NULL)
INSERT [dbo].[Autorizaciones] ([Perfil], [Modulo], [Opcion], [Estado], [Fecha Creación], [Fecha Modif], [Usuario Modif]) VALUES (N'Administrador', N'Admin', N'Usuarios', N'Activo', NULL, NULL, NULL)
INSERT [dbo].[Autorizaciones] ([Perfil], [Modulo], [Opcion], [Estado], [Fecha Creación], [Fecha Modif], [Usuario Modif]) VALUES (N'Administrador', N'Config', N'Areas', N'Activo', NULL, NULL, NULL)
INSERT [dbo].[Autorizaciones] ([Perfil], [Modulo], [Opcion], [Estado], [Fecha Creación], [Fecha Modif], [Usuario Modif]) VALUES (N'Administrador', N'Config', N'Causas Det', N'Activo', NULL, NULL, NULL)
INSERT [dbo].[Autorizaciones] ([Perfil], [Modulo], [Opcion], [Estado], [Fecha Creación], [Fecha Modif], [Usuario Modif]) VALUES (N'Administrador', N'Config', N'Centros', N'Activo', NULL, NULL, NULL)
INSERT [dbo].[Autorizaciones] ([Perfil], [Modulo], [Opcion], [Estado], [Fecha Creación], [Fecha Modif], [Usuario Modif]) VALUES (N'Administrador', N'Config', N'Cfg Planillas', N'Activo', NULL, NULL, NULL)
INSERT [dbo].[Autorizaciones] ([Perfil], [Modulo], [Opcion], [Estado], [Fecha Creación], [Fecha Modif], [Usuario Modif]) VALUES (N'Administrador', N'Config', N'Controles', N'Activo', NULL, NULL, NULL)
INSERT [dbo].[Autorizaciones] ([Perfil], [Modulo], [Opcion], [Estado], [Fecha Creación], [Fecha Modif], [Usuario Modif]) VALUES (N'Administrador', N'Config', N'Detenciones', N'Activo', NULL, NULL, NULL)
INSERT [dbo].[Autorizaciones] ([Perfil], [Modulo], [Opcion], [Estado], [Fecha Creación], [Fecha Modif], [Usuario Modif]) VALUES (N'Administrador', N'Config', N'Dotaciones', N'Activo', NULL, NULL, NULL)
INSERT [dbo].[Autorizaciones] ([Perfil], [Modulo], [Opcion], [Estado], [Fecha Creación], [Fecha Modif], [Usuario Modif]) VALUES (N'Administrador', N'Config', N'Equipos', N'Activo', NULL, NULL, NULL)
INSERT [dbo].[Autorizaciones] ([Perfil], [Modulo], [Opcion], [Estado], [Fecha Creación], [Fecha Modif], [Usuario Modif]) VALUES (N'Administrador', N'Config', N'Familia', N'Activo', NULL, NULL, NULL)
INSERT [dbo].[Autorizaciones] ([Perfil], [Modulo], [Opcion], [Estado], [Fecha Creación], [Fecha Modif], [Usuario Modif]) VALUES (N'Administrador', N'Config', N'Formatos', N'Activo', NULL, NULL, NULL)
INSERT [dbo].[Autorizaciones] ([Perfil], [Modulo], [Opcion], [Estado], [Fecha Creación], [Fecha Modif], [Usuario Modif]) VALUES (N'Administrador', N'Config', N'Global', N'Activo', NULL, NULL, NULL)
INSERT [dbo].[Autorizaciones] ([Perfil], [Modulo], [Opcion], [Estado], [Fecha Creación], [Fecha Modif], [Usuario Modif]) VALUES (N'Administrador', N'Config', N'Incidentes', N'Activo', NULL, NULL, NULL)
INSERT [dbo].[Autorizaciones] ([Perfil], [Modulo], [Opcion], [Estado], [Fecha Creación], [Fecha Modif], [Usuario Modif]) VALUES (N'Administrador', N'Config', N'Layout', N'Activo', NULL, NULL, NULL)
INSERT [dbo].[Autorizaciones] ([Perfil], [Modulo], [Opcion], [Estado], [Fecha Creación], [Fecha Modif], [Usuario Modif]) VALUES (N'Administrador', N'Config', N'Marcas', N'Activo', NULL, NULL, NULL)
INSERT [dbo].[Autorizaciones] ([Perfil], [Modulo], [Opcion], [Estado], [Fecha Creación], [Fecha Modif], [Usuario Modif]) VALUES (N'Administrador', N'Config', N'Materiales', N'Activo', NULL, NULL, NULL)
INSERT [dbo].[Autorizaciones] ([Perfil], [Modulo], [Opcion], [Estado], [Fecha Creación], [Fecha Modif], [Usuario Modif]) VALUES (N'Administrador', N'Config', N'Plantas', N'Activo', NULL, NULL, NULL)
INSERT [dbo].[Autorizaciones] ([Perfil], [Modulo], [Opcion], [Estado], [Fecha Creación], [Fecha Modif], [Usuario Modif]) VALUES (N'Administrador', N'Config', N'Procesos', N'Activo', NULL, NULL, NULL)
INSERT [dbo].[Autorizaciones] ([Perfil], [Modulo], [Opcion], [Estado], [Fecha Creación], [Fecha Modif], [Usuario Modif]) VALUES (N'Administrador', N'Config', N'Productos', N'Activo', NULL, NULL, NULL)
INSERT [dbo].[Autorizaciones] ([Perfil], [Modulo], [Opcion], [Estado], [Fecha Creación], [Fecha Modif], [Usuario Modif]) VALUES (N'Administrador', N'Config', N'Secuencias', N'Activo', NULL, NULL, NULL)
INSERT [dbo].[Autorizaciones] ([Perfil], [Modulo], [Opcion], [Estado], [Fecha Creación], [Fecha Modif], [Usuario Modif]) VALUES (N'Administrador', N'Config', N'TipoInci', N'Activo', NULL, NULL, NULL)
INSERT [dbo].[Autorizaciones] ([Perfil], [Modulo], [Opcion], [Estado], [Fecha Creación], [Fecha Modif], [Usuario Modif]) VALUES (N'Administrador', N'Config', N'Tipos Detencion', N'Activo', NULL, NULL, NULL)
INSERT [dbo].[Autorizaciones] ([Perfil], [Modulo], [Opcion], [Estado], [Fecha Creación], [Fecha Modif], [Usuario Modif]) VALUES (N'Administrador', N'Config', N'Turnos', N'Activo', NULL, NULL, NULL)
INSERT [dbo].[Autorizaciones] ([Perfil], [Modulo], [Opcion], [Estado], [Fecha Creación], [Fecha Modif], [Usuario Modif]) VALUES (N'Administrador', N'Config', N'Turnos x Planta', N'Activo', NULL, NULL, NULL)
INSERT [dbo].[Autorizaciones] ([Perfil], [Modulo], [Opcion], [Estado], [Fecha Creación], [Fecha Modif], [Usuario Modif]) VALUES (N'Administrador', N'Config', N'Unidades', N'Activo', NULL, NULL, NULL)
INSERT [dbo].[Autorizaciones] ([Perfil], [Modulo], [Opcion], [Estado], [Fecha Creación], [Fecha Modif], [Usuario Modif]) VALUES (N'Administrador', N'Config', N'Variables', N'Activo', NULL, NULL, NULL)
INSERT [dbo].[Autorizaciones] ([Perfil], [Modulo], [Opcion], [Estado], [Fecha Creación], [Fecha Modif], [Usuario Modif]) VALUES (N'Administrador', N'Detenciones', N'Detención', N'Activo', NULL, NULL, NULL)
INSERT [dbo].[Autorizaciones] ([Perfil], [Modulo], [Opcion], [Estado], [Fecha Creación], [Fecha Modif], [Usuario Modif]) VALUES (N'Administrador', N'Detenciones', N'RDetFec', N'Activo', NULL, NULL, NULL)
INSERT [dbo].[Autorizaciones] ([Perfil], [Modulo], [Opcion], [Estado], [Fecha Creación], [Fecha Modif], [Usuario Modif]) VALUES (N'Administrador', N'Incidentes', N'ModIncidentes', N'Activo', NULL, NULL, NULL)
INSERT [dbo].[Autorizaciones] ([Perfil], [Modulo], [Opcion], [Estado], [Fecha Creación], [Fecha Modif], [Usuario Modif]) VALUES (N'Administrador', N'Incidentes', N'Reg Incidentes', N'Activo', NULL, NULL, NULL)
INSERT [dbo].[Autorizaciones] ([Perfil], [Modulo], [Opcion], [Estado], [Fecha Creación], [Fecha Modif], [Usuario Modif]) VALUES (N'Administrador', N'Incidentes', N'Rep Incidentes', N'Activo', NULL, NULL, NULL)
INSERT [dbo].[Autorizaciones] ([Perfil], [Modulo], [Opcion], [Estado], [Fecha Creación], [Fecha Modif], [Usuario Modif]) VALUES (N'Administrador', N'Planif', N'OF', N'Activo', NULL, NULL, NULL)
INSERT [dbo].[Autorizaciones] ([Perfil], [Modulo], [Opcion], [Estado], [Fecha Creación], [Fecha Modif], [Usuario Modif]) VALUES (N'Administrador', N'Planif', N'Plan Producción', N'Activo', NULL, NULL, NULL)
INSERT [dbo].[Autorizaciones] ([Perfil], [Modulo], [Opcion], [Estado], [Fecha Creación], [Fecha Modif], [Usuario Modif]) VALUES (N'Administrador', N'Producción', N'Notificacion', N'Activo', NULL, NULL, NULL)
INSERT [dbo].[Autorizaciones] ([Perfil], [Modulo], [Opcion], [Estado], [Fecha Creación], [Fecha Modif], [Usuario Modif]) VALUES (N'Administrador', N'Prueba', N'Prueba', N'Activo', NULL, NULL, NULL)
INSERT [dbo].[Autorizaciones] ([Perfil], [Modulo], [Opcion], [Estado], [Fecha Creación], [Fecha Modif], [Usuario Modif]) VALUES (N'Administrador', N'Prueba', N'Prueba2', N'Activo', NULL, NULL, NULL)
INSERT [dbo].[Autorizaciones] ([Perfil], [Modulo], [Opcion], [Estado], [Fecha Creación], [Fecha Modif], [Usuario Modif]) VALUES (N'OP-ENV-VIE', N'Producción', N'Notificacion', N'Activo', NULL, NULL, NULL)
INSERT [dbo].[CausasDetencion] ([Causa], [Descripción], [Tipo], [Planificada], [Estandar], [Mantencion], [Fecha Creación], [Estado]) VALUES (N'110', N'Aseo y lavado diario', N'11', N'Si', N'Si', N'No', NULL, N'Activo')
INSERT [dbo].[CausasDetencion] ([Causa], [Descripción], [Tipo], [Planificada], [Estandar], [Mantencion], [Fecha Creación], [Estado]) VALUES (N'112', N'Aseo y lavado Semanal', N'11', N'Si', N'Si', N'No', NULL, N'Activo')
INSERT [dbo].[CausasDetencion] ([Causa], [Descripción], [Tipo], [Planificada], [Estandar], [Mantencion], [Fecha Creación], [Estado]) VALUES (N'113', N'Detencion limpieza fechador', N'11', N'Si', N'Si', N'No', NULL, N'Activo')
INSERT [dbo].[CausasDetencion] ([Causa], [Descripción], [Tipo], [Planificada], [Estandar], [Mantencion], [Fecha Creación], [Estado]) VALUES (N'114', N'Lavado de Filtros', N'11', N'Si', N'Si', N'No', NULL, N'Activo')
INSERT [dbo].[CausasDetencion] ([Causa], [Descripción], [Tipo], [Planificada], [Estandar], [Mantencion], [Fecha Creación], [Estado]) VALUES (N'115', N'Lavado de Rejillas', N'11', N'Si', N'Si', N'No', NULL, N'Activo')
INSERT [dbo].[CausasDetencion] ([Causa], [Descripción], [Tipo], [Planificada], [Estandar], [Mantencion], [Fecha Creación], [Estado]) VALUES (N'116', N'Lavado de moldes', N'11', N'Si', N'Si', N'No', NULL, N'Activo')
INSERT [dbo].[CausasDetencion] ([Causa], [Descripción], [Tipo], [Planificada], [Estandar], [Mantencion], [Fecha Creación], [Estado]) VALUES (N'117', N'Prelavado y sanitizado', N'11', N'Si', N'Si', N'No', NULL, N'Activo')
INSERT [dbo].[CausasDetencion] ([Causa], [Descripción], [Tipo], [Planificada], [Estandar], [Mantencion], [Fecha Creación], [Estado]) VALUES (N'120', N'Cambio de alambre', N'12', N'No', N'Si', N'No', NULL, N'Activo')
INSERT [dbo].[CausasDetencion] ([Causa], [Descripción], [Tipo], [Planificada], [Estandar], [Mantencion], [Fecha Creación], [Estado]) VALUES (N'121', N'Cambio bozal', N'12', N'No', N'Si', N'No', NULL, N'Activo')
INSERT [dbo].[CausasDetencion] ([Causa], [Descripción], [Tipo], [Planificada], [Estandar], [Mantencion], [Fecha Creación], [Estado]) VALUES (N'122', N'Cambio bulbos húmedos', N'12', N'No', N'Si', N'No', NULL, N'Activo')
INSERT [dbo].[CausasDetencion] ([Causa], [Descripción], [Tipo], [Planificada], [Estandar], [Mantencion], [Fecha Creación], [Estado]) VALUES (N'123', N'Cambio carro eslabonador', N'12', N'No', N'Si', N'No', NULL, N'Activo')
INSERT [dbo].[CausasDetencion] ([Causa], [Descripción], [Tipo], [Planificada], [Estandar], [Mantencion], [Fecha Creación], [Estado]) VALUES (N'124', N'Cambio tubo', N'12', N'No', N'Si', N'No', NULL, N'Activo')
INSERT [dbo].[CausasDetencion] ([Causa], [Descripción], [Tipo], [Planificada], [Estandar], [Mantencion], [Fecha Creación], [Estado]) VALUES (N'125', N'Cambio elemento corte', N'12', N'No', N'Si', N'No', NULL, N'Activo')
INSERT [dbo].[Centros] ([Centro], [Descripción], [Dirección], [Fecha Creación], [Estado]) VALUES (N'P1', N'San Jorge', N'A. Vespucio 2341, Pudahuel', NULL, N'Activo')
INSERT [dbo].[Centros] ([Centro], [Descripción], [Dirección], [Fecha Creación], [Estado]) VALUES (N'P2', N'La Preferida', N'A.Vespucio 1830, Quilicura', NULL, N'Activo')
INSERT [dbo].[Centros] ([Centro], [Descripción], [Dirección], [Fecha Creación], [Estado]) VALUES (N'P3', N'Winter', N'Montreal 4561, San Miguel', NULL, N'Activo')
INSERT [dbo].[Detenciones] ([NroDetencion], [Equipo], [CodigoCausaPrimario], [CodigoCausaSecundario], [FechaDetencion], [InicioDetencion], [FinDetencion], [Observaciones], [Usuario], [FechaGrabacion]) VALUES (10005, N'E-VIE-13', N'112', NULL, N'18-10-2015 ', N'09:50', N'10:15', NULL, N'Fernando.Carrasco', CAST(N'2015-10-20 15:03:10.263' AS DateTime))
INSERT [dbo].[Detenciones] ([NroDetencion], [Equipo], [CodigoCausaPrimario], [CodigoCausaSecundario], [FechaDetencion], [InicioDetencion], [FinDetencion], [Observaciones], [Usuario], [FechaGrabacion]) VALUES (10006, N'E-VIE-19', N'113', NULL, N'18-10-2015', N'11:02', N'11:34', NULL, N'Fernando.Carrasco', CAST(N'2015-10-20 15:03:21.320' AS DateTime))
INSERT [dbo].[Detenciones] ([NroDetencion], [Equipo], [CodigoCausaPrimario], [CodigoCausaSecundario], [FechaDetencion], [InicioDetencion], [FinDetencion], [Observaciones], [Usuario], [FechaGrabacion]) VALUES (10007, N'E-VIE-14', N'125', NULL, N'18-10-2015', N'14:15', N'15:10', N'Equipo requiere ajuste mayor', N'Fernando.Carrasco', CAST(N'2015-10-20 15:03:31.717' AS DateTime))
INSERT [dbo].[Detenciones] ([NroDetencion], [Equipo], [CodigoCausaPrimario], [CodigoCausaSecundario], [FechaDetencion], [InicioDetencion], [FinDetencion], [Observaciones], [Usuario], [FechaGrabacion]) VALUES (10008, N'E-VIE-13', N'113', NULL, N'19-10-2015', N'09:30', N'10:15', NULL, N'Fernando.Carrasco', CAST(N'2015-10-20 00:00:00.000' AS DateTime))
INSERT [dbo].[Detenciones] ([NroDetencion], [Equipo], [CodigoCausaPrimario], [CodigoCausaSecundario], [FechaDetencion], [InicioDetencion], [FinDetencion], [Observaciones], [Usuario], [FechaGrabacion]) VALUES (10009, N'E-VIE-13', N'114', NULL, N'19-10-2015', N'11:55', N'12:55', NULL, N'Fernando.Carrasco', CAST(N'2015-10-20 00:00:00.000' AS DateTime))
INSERT [dbo].[Detenciones] ([NroDetencion], [Equipo], [CodigoCausaPrimario], [CodigoCausaSecundario], [FechaDetencion], [InicioDetencion], [FinDetencion], [Observaciones], [Usuario], [FechaGrabacion]) VALUES (10010, N'E-VIE-13', N'110', N'124', N'20-10-2015', N'15:05', N'15:20', NULL, N'Fernando.Carrasco', CAST(N'2015-10-20 15:12:47.280' AS DateTime))
INSERT [dbo].[Detenciones] ([NroDetencion], [Equipo], [CodigoCausaPrimario], [CodigoCausaSecundario], [FechaDetencion], [InicioDetencion], [FinDetencion], [Observaciones], [Usuario], [FechaGrabacion]) VALUES (10019, N'E-VIE-13', N'114', N'110', N'28-10-2015', N'11:00', N'11:45', N'Prueba detención 28-oct', N'Andres.Ulloa', CAST(N'2015-10-28 11:49:32.690' AS DateTime))
INSERT [dbo].[Detenciones] ([NroDetencion], [Equipo], [CodigoCausaPrimario], [CodigoCausaSecundario], [FechaDetencion], [InicioDetencion], [FinDetencion], [Observaciones], [Usuario], [FechaGrabacion]) VALUES (10020, N'E-VIE-13', N'110', NULL, N'29-10-2015', N'04:24', N'04:24', NULL, N'Fernando.Carrasco', CAST(N'2015-10-29 00:00:00.000' AS DateTime))
INSERT [dbo].[Equipos] ([Equipo], [Descripción], [Proceso], [Fecha Creación], [Estado]) VALUES (N'E-VIE-10', N'Horno J-CON', N'PR-VIE-04', N'Aug 27 2015 11:53AM', N'Activo')
INSERT [dbo].[Equipos] ([Equipo], [Descripción], [Proceso], [Fecha Creación], [Estado]) VALUES (N'E-VIE-11', N'Horno Alkar#1', N'PR-VIE-04', N'Aug 27 2015 12:02PM', N'Activo')
INSERT [dbo].[Equipos] ([Equipo], [Descripción], [Proceso], [Fecha Creación], [Estado]) VALUES (N'E-VIE-12', N'Horno Alkar#2', N'PR-VIE-04', N'Aug 27 2015 12:03PM', N'Activo')
INSERT [dbo].[Equipos] ([Equipo], [Descripción], [Proceso], [Fecha Creación], [Estado]) VALUES (N'E-VIE-13', N'Multivac R530#2', N'PR-VIE-06', N'Aug 27 2015 12:04PM', N'Activo')
INSERT [dbo].[Equipos] ([Equipo], [Descripción], [Proceso], [Fecha Creación], [Estado]) VALUES (N'E-VIE-14', N'Multivac R530#3', N'PR-VIE-06', N'Aug 27 2015 12:04PM', N'Activo')
INSERT [dbo].[Equipos] ([Equipo], [Descripción], [Proceso], [Fecha Creación], [Estado]) VALUES (N'E-VIE-15', N'Multivac R530#4', N'PR-VIE-06', N'Aug 27 2015 12:05PM', N'Activo')
INSERT [dbo].[Equipos] ([Equipo], [Descripción], [Proceso], [Fecha Creación], [Estado]) VALUES (N'E-VIE-16', N'Multivac R535#4', N'PR-VIE-06', N'Aug 27 2015 12:05PM', N'Activo')
INSERT [dbo].[Equipos] ([Equipo], [Descripción], [Proceso], [Fecha Creación], [Estado]) VALUES (N'E-VIE-17', N'Multivac R535#8', N'PR-VIE-06', N'Aug 27 2015 12:06PM', N'Activo')
INSERT [dbo].[Equipos] ([Equipo], [Descripción], [Proceso], [Fecha Creación], [Estado]) VALUES (N'E-VIE-18', N'Multivac R240#6', N'PR-VIE-06', N'Aug 27 2015 12:07PM', N'Activo')
INSERT [dbo].[Equipos] ([Equipo], [Descripción], [Proceso], [Fecha Creación], [Estado]) VALUES (N'E-VIE-19', N'Tiromat Winter', N'PR-VIE-06', N'Aug 27 2015 12:08PM', N'Activo')
INSERT [dbo].[Equipos] ([Equipo], [Descripción], [Proceso], [Fecha Creación], [Estado]) VALUES (N'E-VIE-20', N'Tiromat', N'PR-VIE-06', N'Aug 27 2015 12:08PM', N'Activo')
INSERT [dbo].[Equipos] ([Equipo], [Descripción], [Proceso], [Fecha Creación], [Estado]) VALUES (N'NL17-5', N'Embutidora Vienesas #5', N'PR-VIE-03', N'Sep 21 2015  4:50PM ', N'Activo')
INSERT [dbo].[Equipos] ([Equipo], [Descripción], [Proceso], [Fecha Creación], [Estado]) VALUES (N'NL17-6', N'Embutidora Vienesas #6', N'PR-VIE-03', N'Sep 21 2015  4:51PM ', N'Activo')
INSERT [dbo].[Equipos] ([Equipo], [Descripción], [Proceso], [Fecha Creación], [Estado]) VALUES (N'NL17-7', N'Embutidora Vienesas #7', N'PR-VIE-03', N'Sep 21 2015  4:52PM ', N'Activo')
INSERT [dbo].[Equipos] ([Equipo], [Descripción], [Proceso], [Fecha Creación], [Estado]) VALUES (N'NL17-8', N'Embutidora Vienesas #8', N'PR-VIE-03', N'Sep 21 2015  4:52PM ', N'Activo')
INSERT [dbo].[Equipos] ([Equipo], [Descripción], [Proceso], [Fecha Creación], [Estado]) VALUES (N'NL21-1', N'Embutidora Vienesas #1', N'PR-VIE-03', N'Sep 21 2015  4:54PM ', N'Activo')
INSERT [dbo].[Equipos] ([Equipo], [Descripción], [Proceso], [Fecha Creación], [Estado]) VALUES (N'NL21-2', N'Embutidora Vienesas #2', N'PR-VIE-03', N'Sep 21 2015  4:54PM ', N'Activo')
INSERT [dbo].[Equipos] ([Equipo], [Descripción], [Proceso], [Fecha Creación], [Estado]) VALUES (N'NL21-3', N'Embutidora Vienesas #3', N'PR-VIE-03', N'Sep 21 2015  4:53PM ', N'Activo')
INSERT [dbo].[Equipos] ([Equipo], [Descripción], [Proceso], [Fecha Creación], [Estado]) VALUES (N'NL21-4', N'Embutidora Vienesas #4', N'PR-VIE-03', N'Sep 21 2015  4:52PM ', N'Activo')
INSERT [dbo].[Estados] ([Estado]) VALUES (N'Activo')
INSERT [dbo].[Estados] ([Estado]) VALUES (N'Inactivo')
INSERT [dbo].[FamiliaProductos] ([Codigo], [FamiliaProducto], [Estado]) VALUES (N'01', N'Vienesas', N'Activo')
INSERT [dbo].[FamiliaProductos] ([Codigo], [FamiliaProducto], [Estado]) VALUES (N'02', N'Salames', N'Activo')
INSERT [dbo].[FamiliaProductos] ([Codigo], [FamiliaProducto], [Estado]) VALUES (N'03', N'Laminados', N'Activo')
INSERT [dbo].[FamiliaProductos] ([Codigo], [FamiliaProducto], [Estado]) VALUES (N'04', N'Mortadelas', N'Activo')
INSERT [dbo].[FamiliaProductos] ([Codigo], [FamiliaProducto], [Estado]) VALUES (N'05', N'Pate', N'Activo')
INSERT [dbo].[FamiliaProductos] ([Codigo], [FamiliaProducto], [Estado]) VALUES (N'06', N'Parrilleros', N'Activo')
INSERT [dbo].[Formatos] ([Formato], [CodigoFamilia], [Rendimiento], [Fecha Creación], [Estado]) VALUES (N'250GR', N'01', CAST(978.120000 AS Numeric(10, 6)), N'Sep  6 2015  1:35AM', N'Activo')
INSERT [dbo].[Formatos] ([Formato], [CodigoFamilia], [Rendimiento], [Fecha Creación], [Estado]) VALUES (N'KILO', N'01', CAST(1400.080000 AS Numeric(10, 6)), N'Sep  6 2015  1:41AM', N'Activo')
INSERT [dbo].[Formatos] ([Formato], [CodigoFamilia], [Rendimiento], [Fecha Creación], [Estado]) VALUES (N'MANUAL', N'01', CAST(619.690814 AS Numeric(10, 6)), N'Sep  6 2015  2:11AM', N'Activo')
SET IDENTITY_INSERT [dbo].[GanttDependencies] ON 

INSERT [dbo].[GanttDependencies] ([ID], [PredecessorID], [SuccessorID], [Type]) VALUES (3, 1, 3, 1)
INSERT [dbo].[GanttDependencies] ([ID], [PredecessorID], [SuccessorID], [Type]) VALUES (5, 3, 2, 1)
SET IDENTITY_INSERT [dbo].[GanttDependencies] OFF
SET IDENTITY_INSERT [dbo].[GanttTasks] ON 

INSERT [dbo].[GanttTasks] ([ID], [ParentID], [OrderID], [Title], [Start], [End], [PercentComplete], [Expanded], [Summary], [Description]) VALUES (1, 4, 0, N'1004', CAST(N'2015-09-06 13:00:00.000' AS DateTime), CAST(N'2015-09-06 16:00:00.000' AS DateTime), CAST(0.00 AS Decimal(5, 2)), 1, 0, N'1020 -Vienesa SJ')
INSERT [dbo].[GanttTasks] ([ID], [ParentID], [OrderID], [Title], [Start], [End], [PercentComplete], [Expanded], [Summary], [Description]) VALUES (2, 5, 0, N'1005', CAST(N'2015-09-06 17:00:00.000' AS DateTime), CAST(N'2015-09-06 18:00:00.000' AS DateTime), CAST(0.00 AS Decimal(5, 2)), 1, 0, N'1021 - Vienesa JK')
INSERT [dbo].[GanttTasks] ([ID], [ParentID], [OrderID], [Title], [Start], [End], [PercentComplete], [Expanded], [Summary], [Description]) VALUES (3, 4, 1, N'Setup', CAST(N'2015-09-06 16:00:00.000' AS DateTime), CAST(N'2015-09-06 17:00:00.000' AS DateTime), CAST(0.00 AS Decimal(5, 2)), 1, 0, N'')
INSERT [dbo].[GanttTasks] ([ID], [ParentID], [OrderID], [Title], [Start], [End], [PercentComplete], [Expanded], [Summary], [Description]) VALUES (4, NULL, 0, N'Envasado #1', CAST(N'2015-09-06 13:00:00.000' AS DateTime), CAST(N'2015-09-06 17:00:00.000' AS DateTime), CAST(0.00 AS Decimal(5, 2)), 1, 1, N'')
INSERT [dbo].[GanttTasks] ([ID], [ParentID], [OrderID], [Title], [Start], [End], [PercentComplete], [Expanded], [Summary], [Description]) VALUES (5, NULL, 1, N'Envasado #2', CAST(N'2015-09-06 17:00:00.000' AS DateTime), CAST(N'2015-09-06 18:00:00.000' AS DateTime), CAST(0.00 AS Decimal(5, 2)), 1, 1, N'')
SET IDENTITY_INSERT [dbo].[GanttTasks] OFF
INSERT [dbo].[Incidentes] ([Incidente], [TipoIncidente], [FechaIncidente], [HoraIncidente], [Planta], [Area], [Proceso], [Equipo], [Usuario], [Asunto], [Descripcion], [IndAlerta]) VALUES (7004, N'MANT', N'23-10-2015', N'00:04', N'VIE', N'VIE03', N'PR-VIE-06', NULL, N'Fernando.Carrasco', N'Prueba', N'Prueba', N'No')
INSERT [dbo].[Incidentes] ([Incidente], [TipoIncidente], [FechaIncidente], [HoraIncidente], [Planta], [Area], [Proceso], [Equipo], [Usuario], [Asunto], [Descripcion], [IndAlerta]) VALUES (7007, N'OTRS', N'23-10-2015', N'07:25', N'VIE', N'VIE03', N'PR-VIE-06', NULL, N'Fernando.Carrasco', N'Caida de red de datos', N'Caida de red de datos', N'No')
INSERT [dbo].[Incidentes] ([Incidente], [TipoIncidente], [FechaIncidente], [HoraIncidente], [Planta], [Area], [Proceso], [Equipo], [Usuario], [Asunto], [Descripcion], [IndAlerta]) VALUES (7008, N'RRHH', N'23-10-2015', N'07:27', N'VIE', N'VIE02', NULL, NULL, N'Fernando.Carrasco', N'Falta dotación', N'Falta dotación', N'No')
INSERT [dbo].[Incidentes] ([Incidente], [TipoIncidente], [FechaIncidente], [HoraIncidente], [Planta], [Area], [Proceso], [Equipo], [Usuario], [Asunto], [Descripcion], [IndAlerta]) VALUES (7009, N'OTRS', N'23-10-2015', N'03:49', N'VIE', NULL, NULL, NULL, N'Andres.Ulloa', N'pppp', N'Incidente en acumulación', N'No')
INSERT [dbo].[Incidentes] ([Incidente], [TipoIncidente], [FechaIncidente], [HoraIncidente], [Planta], [Area], [Proceso], [Equipo], [Usuario], [Asunto], [Descripcion], [IndAlerta]) VALUES (7010, N'OPER', N'26-10-2015', N'09:40', N'VIE', N'VIE03', N'PR-VIE-06', N'E-VIE-18', N'Fernando.Carrasco', N'Falta de insumos', N'Falta de insumos', N'No')
INSERT [dbo].[Incidentes] ([Incidente], [TipoIncidente], [FechaIncidente], [HoraIncidente], [Planta], [Area], [Proceso], [Equipo], [Usuario], [Asunto], [Descripcion], [IndAlerta]) VALUES (7011, N'MANT', N'26-10-2015', N'09:42', N'VIE', N'VIE03', N'PR-VIE-05', NULL, N'Fernando.Carrasco', N'Error en la planificación de dotaciones', N'Error en la planificación de dotaciones', N'No')
INSERT [dbo].[Incidentes] ([Incidente], [TipoIncidente], [FechaIncidente], [HoraIncidente], [Planta], [Area], [Proceso], [Equipo], [Usuario], [Asunto], [Descripcion], [IndAlerta]) VALUES (7012, N'RRHH', N'29-10-2015', N'04:25', N'VIE', N'VIE03', N'PR-VIE-06', NULL, N'Fernando.Carrasco', N'Falta de dotación', N'Falta de Dotación', N'No')
INSERT [dbo].[Marcas] ([Codigo], [Marca], [Estado]) VALUES (N'01', N'San Jorge', N'Activo')
INSERT [dbo].[Marcas] ([Codigo], [Marca], [Estado]) VALUES (N'02', N'La Preferida', N'Activo')
INSERT [dbo].[Marcas] ([Codigo], [Marca], [Estado]) VALUES (N'03', N'Winter', N'Activo')
INSERT [dbo].[Marcas] ([Codigo], [Marca], [Estado]) VALUES (N'04', N'J.K.', N'Activo')
INSERT [dbo].[Marcas] ([Codigo], [Marca], [Estado]) VALUES (N'05', N'Fast Delli', N'Activo')
INSERT [dbo].[Marcas] ([Codigo], [Marca], [Estado]) VALUES (N'06', N'DYS', N'Activo')
INSERT [dbo].[Marcas] ([Codigo], [Marca], [Estado]) VALUES (N'07', N'Werner', N'Activo')
INSERT [dbo].[Marcas] ([Codigo], [Marca], [Estado]) VALUES (N'08', N'Germania', N'Activo')
INSERT [dbo].[Marcas] ([Codigo], [Marca], [Estado]) VALUES (N'09', N'Sopraval', N'Activo')
INSERT [dbo].[Menu_N0] ([Perfil], [Posicion], [Modulo]) VALUES (N'Administrador', 1, N'Inicio')
INSERT [dbo].[Menu_N0] ([Perfil], [Posicion], [Modulo]) VALUES (N'Administrador', 2, N'Admin')
INSERT [dbo].[Menu_N0] ([Perfil], [Posicion], [Modulo]) VALUES (N'Administrador', 3, N'Config')
INSERT [dbo].[Menu_N0] ([Perfil], [Posicion], [Modulo]) VALUES (N'Administrador', 4, N'Planif')
INSERT [dbo].[Menu_N0] ([Perfil], [Posicion], [Modulo]) VALUES (N'Administrador', 5, N'Producción')
INSERT [dbo].[Menu_N0] ([Perfil], [Posicion], [Modulo]) VALUES (N'Administrador', 6, N'Detenciones')
INSERT [dbo].[Menu_N0] ([Perfil], [Posicion], [Modulo]) VALUES (N'Administrador', 7, N'Incidentes')
INSERT [dbo].[Menu_N0] ([Perfil], [Posicion], [Modulo]) VALUES (N'OP-ENV-VIE', 1, N'Inicio')
INSERT [dbo].[Menu_N0] ([Perfil], [Posicion], [Modulo]) VALUES (N'OP-ENV-VIE', 2, N'Planif')
INSERT [dbo].[Menu_N0] ([Perfil], [Posicion], [Modulo]) VALUES (N'OP-ENV-VIE', 3, N'Producción')
INSERT [dbo].[Menu_N1] ([Perfil], [Modulo], [Posicion], [Opcion]) VALUES (N'Administrador', N'Admin', 1, N'Módulos')
INSERT [dbo].[Menu_N1] ([Perfil], [Modulo], [Posicion], [Opcion]) VALUES (N'Administrador', N'Admin', 2, N'Opciones')
INSERT [dbo].[Menu_N1] ([Perfil], [Modulo], [Posicion], [Opcion]) VALUES (N'Administrador', N'Admin', 3, N'Perfiles')
INSERT [dbo].[Menu_N1] ([Perfil], [Modulo], [Posicion], [Opcion]) VALUES (N'Administrador', N'Admin', 4, N'Autorizaciones')
INSERT [dbo].[Menu_N1] ([Perfil], [Modulo], [Posicion], [Opcion]) VALUES (N'Administrador', N'Admin', 5, N'Menus')
INSERT [dbo].[Menu_N1] ([Perfil], [Modulo], [Posicion], [Opcion]) VALUES (N'Administrador', N'Admin', 6, N'Usuarios')
INSERT [dbo].[Menu_N1] ([Perfil], [Modulo], [Posicion], [Opcion]) VALUES (N'Administrador', N'Config', 1, N'Global')
INSERT [dbo].[Menu_N1] ([Perfil], [Modulo], [Posicion], [Opcion]) VALUES (N'Administrador', N'Config', 2, N'Layout')
INSERT [dbo].[Menu_N1] ([Perfil], [Modulo], [Posicion], [Opcion]) VALUES (N'Administrador', N'Config', 3, N'Detenciones')
INSERT [dbo].[Menu_N1] ([Perfil], [Modulo], [Posicion], [Opcion]) VALUES (N'Administrador', N'Config', 4, N'Materiales')
INSERT [dbo].[Menu_N1] ([Perfil], [Modulo], [Posicion], [Opcion]) VALUES (N'Administrador', N'Config', 5, N'Controles')
INSERT [dbo].[Menu_N1] ([Perfil], [Modulo], [Posicion], [Opcion]) VALUES (N'Administrador', N'Config', 6, N'Dotaciones')
INSERT [dbo].[Menu_N1] ([Perfil], [Modulo], [Posicion], [Opcion]) VALUES (N'Administrador', N'Config', 7, N'Incidentes')
INSERT [dbo].[Menu_N1] ([Perfil], [Modulo], [Posicion], [Opcion]) VALUES (N'Administrador', N'Detenciones', 1, N'Detención')
INSERT [dbo].[Menu_N1] ([Perfil], [Modulo], [Posicion], [Opcion]) VALUES (N'Administrador', N'Detenciones', 2, N'RDetFec')
INSERT [dbo].[Menu_N1] ([Perfil], [Modulo], [Posicion], [Opcion]) VALUES (N'Administrador', N'Incidentes', 1, N'Reg Incidentes')
INSERT [dbo].[Menu_N1] ([Perfil], [Modulo], [Posicion], [Opcion]) VALUES (N'Administrador', N'Incidentes', 2, N'ModIncidentes')
INSERT [dbo].[Menu_N1] ([Perfil], [Modulo], [Posicion], [Opcion]) VALUES (N'Administrador', N'Incidentes', 3, N'Rep Incidentes')
INSERT [dbo].[Menu_N1] ([Perfil], [Modulo], [Posicion], [Opcion]) VALUES (N'Administrador', N'Planif', 1, N'OF')
INSERT [dbo].[Menu_N1] ([Perfil], [Modulo], [Posicion], [Opcion]) VALUES (N'Administrador', N'Planif', 2, N'Plan Producción')
INSERT [dbo].[Menu_N1] ([Perfil], [Modulo], [Posicion], [Opcion]) VALUES (N'Administrador', N'Producción', 1, N'Notificacion')
INSERT [dbo].[Menu_N1] ([Perfil], [Modulo], [Posicion], [Opcion]) VALUES (N'Administrador', N'Prueba', 1, N'Prueba')
INSERT [dbo].[Menu_N1] ([Perfil], [Modulo], [Posicion], [Opcion]) VALUES (N'Administrador', N'Prueba', 2, N'Prueba2')
INSERT [dbo].[Menu_N1] ([Perfil], [Modulo], [Posicion], [Opcion]) VALUES (N'OP-ENV-VIE', N'Planif', 1, N'Plan Producción')
INSERT [dbo].[Menu_N1] ([Perfil], [Modulo], [Posicion], [Opcion]) VALUES (N'OP-ENV-VIE', N'Producción', 1, N'Notificacion')
INSERT [dbo].[Menu_N2] ([Perfil], [Modulo], [Posicion], [Opcion1], [Opcion2]) VALUES (N'Administrador', N'Admin', 1, N'Usuarios', N'Usuario Fn')
INSERT [dbo].[Menu_N2] ([Perfil], [Modulo], [Posicion], [Opcion1], [Opcion2]) VALUES (N'Administrador', N'Config', 1, N'Controles', N'Variables')
INSERT [dbo].[Menu_N2] ([Perfil], [Modulo], [Posicion], [Opcion1], [Opcion2]) VALUES (N'Administrador', N'Config', 1, N'Detenciones', N'Tipos Detencion')
INSERT [dbo].[Menu_N2] ([Perfil], [Modulo], [Posicion], [Opcion1], [Opcion2]) VALUES (N'Administrador', N'Config', 1, N'Dotaciones', N'Turnos')
INSERT [dbo].[Menu_N2] ([Perfil], [Modulo], [Posicion], [Opcion1], [Opcion2]) VALUES (N'Administrador', N'Config', 1, N'Global', N'Unidades')
INSERT [dbo].[Menu_N2] ([Perfil], [Modulo], [Posicion], [Opcion1], [Opcion2]) VALUES (N'Administrador', N'Config', 1, N'Incidentes', N'TipoInci')
INSERT [dbo].[Menu_N2] ([Perfil], [Modulo], [Posicion], [Opcion1], [Opcion2]) VALUES (N'Administrador', N'Config', 1, N'Layout', N'Centros')
INSERT [dbo].[Menu_N2] ([Perfil], [Modulo], [Posicion], [Opcion1], [Opcion2]) VALUES (N'Administrador', N'Config', 1, N'Materiales', N'Marcas')
INSERT [dbo].[Menu_N2] ([Perfil], [Modulo], [Posicion], [Opcion1], [Opcion2]) VALUES (N'Administrador', N'Config', 2, N'Controles', N'Cfg Planillas')
INSERT [dbo].[Menu_N2] ([Perfil], [Modulo], [Posicion], [Opcion1], [Opcion2]) VALUES (N'Administrador', N'Config', 2, N'Detenciones', N'Causas Det')
INSERT [dbo].[Menu_N2] ([Perfil], [Modulo], [Posicion], [Opcion1], [Opcion2]) VALUES (N'Administrador', N'Config', 2, N'Dotaciones', N'Turnos x Planta')
INSERT [dbo].[Menu_N2] ([Perfil], [Modulo], [Posicion], [Opcion1], [Opcion2]) VALUES (N'Administrador', N'Config', 2, N'Global', N'Secuencias')
INSERT [dbo].[Menu_N2] ([Perfil], [Modulo], [Posicion], [Opcion1], [Opcion2]) VALUES (N'Administrador', N'Config', 2, N'Layout', N'Plantas')
INSERT [dbo].[Menu_N2] ([Perfil], [Modulo], [Posicion], [Opcion1], [Opcion2]) VALUES (N'Administrador', N'Config', 2, N'Materiales', N'Familia')
INSERT [dbo].[Menu_N2] ([Perfil], [Modulo], [Posicion], [Opcion1], [Opcion2]) VALUES (N'Administrador', N'Config', 3, N'Layout', N'Areas')
INSERT [dbo].[Menu_N2] ([Perfil], [Modulo], [Posicion], [Opcion1], [Opcion2]) VALUES (N'Administrador', N'Config', 3, N'Materiales', N'Formatos')
INSERT [dbo].[Menu_N2] ([Perfil], [Modulo], [Posicion], [Opcion1], [Opcion2]) VALUES (N'Administrador', N'Config', 4, N'Layout', N'Procesos')
INSERT [dbo].[Menu_N2] ([Perfil], [Modulo], [Posicion], [Opcion1], [Opcion2]) VALUES (N'Administrador', N'Config', 4, N'Materiales', N'Productos')
INSERT [dbo].[Menu_N2] ([Perfil], [Modulo], [Posicion], [Opcion1], [Opcion2]) VALUES (N'Administrador', N'Config', 5, N'Layout', N'Equipos')
INSERT [dbo].[Modulos] ([Modulo], [Descripción], [Estado]) VALUES (N'Admin', N'Administración acceso', N'Activo')
INSERT [dbo].[Modulos] ([Modulo], [Descripción], [Estado]) VALUES (N'Config', N'Configuración Datos Maestros', N'Activo')
INSERT [dbo].[Modulos] ([Modulo], [Descripción], [Estado]) VALUES (N'Detenciones', N'Detenciones', N'Activo')
INSERT [dbo].[Modulos] ([Modulo], [Descripción], [Estado]) VALUES (N'Incidentes', N'Incidentes', N'Activo')
INSERT [dbo].[Modulos] ([Modulo], [Descripción], [Estado]) VALUES (N'Inicio', N'Inicio', N'Activo')
INSERT [dbo].[Modulos] ([Modulo], [Descripción], [Estado]) VALUES (N'Planif', N'Planificación', N'Activo')
INSERT [dbo].[Modulos] ([Modulo], [Descripción], [Estado]) VALUES (N'Producción', N'Producción', N'Activo')
INSERT [dbo].[Notificaciones] ([OrdenFab], [Lote], [LoteSAP], [Equipo], [Inicio], [Fin], [Usuario], [FechaModificacion], [Producción], [Rechazo], [CausaRechazo]) VALUES (N'2026', 1, NULL, N'e1', N'16:30', N'17:50', N'Fernando.Carrasco', N'29-09-2015 16:40:56', CAST(15000 AS Numeric(18, 0)), NULL, NULL)
INSERT [dbo].[Notificaciones] ([OrdenFab], [Lote], [LoteSAP], [Equipo], [Inicio], [Fin], [Usuario], [FechaModificacion], [Producción], [Rechazo], [CausaRechazo]) VALUES (N'2034', 1, NULL, N'E-VIE-13', N'14:15', N'15:00', N'Fernando.Carrasco', N'30-09-2015 21:09:17', CAST(5000 AS Numeric(18, 0)), NULL, NULL)
INSERT [dbo].[Notificaciones] ([OrdenFab], [Lote], [LoteSAP], [Equipo], [Inicio], [Fin], [Usuario], [FechaModificacion], [Producción], [Rechazo], [CausaRechazo]) VALUES (N'2039', 1, NULL, N'E-VIE-13', N'08:30', N'09:15', N'Fernando.Carrasco', N'01-10-2015 14:39:21', CAST(14500 AS Numeric(18, 0)), NULL, NULL)
INSERT [dbo].[Notificaciones] ([OrdenFab], [Lote], [LoteSAP], [Equipo], [Inicio], [Fin], [Usuario], [FechaModificacion], [Producción], [Rechazo], [CausaRechazo]) VALUES (N'2040', 1, NULL, N'E-VIE-13', N'09:00', N'09:50', N'Fernando.Carrasco', N'01-10-2015 15:16:27', CAST(4000 AS Numeric(18, 0)), NULL, NULL)
INSERT [dbo].[Notificaciones] ([OrdenFab], [Lote], [LoteSAP], [Equipo], [Inicio], [Fin], [Usuario], [FechaModificacion], [Producción], [Rechazo], [CausaRechazo]) VALUES (N'2053', 1, NULL, N'E-VIE-13', N'07:15', N'07:50', N'Fernando.Carrasco', N'05-10-2015 12:58:47', CAST(26000 AS Numeric(18, 0)), NULL, NULL)
INSERT [dbo].[Notificaciones] ([OrdenFab], [Lote], [LoteSAP], [Equipo], [Inicio], [Fin], [Usuario], [FechaModificacion], [Producción], [Rechazo], [CausaRechazo]) VALUES (N'2053', 2, NULL, N'E-VIE-13', N'08:00', N'08:30', N'Fernando.Carrasco', N'05-10-2015 17:15:38', CAST(3000 AS Numeric(18, 0)), NULL, NULL)
INSERT [dbo].[Notificaciones] ([OrdenFab], [Lote], [LoteSAP], [Equipo], [Inicio], [Fin], [Usuario], [FechaModificacion], [Producción], [Rechazo], [CausaRechazo]) VALUES (N'2053', 3, NULL, N'E-VIE-13', N'09:00', N'09:15', N'Fernando.Carrasco', N'05-10-2015 23:50:24', CAST(6000 AS Numeric(18, 0)), NULL, NULL)
INSERT [dbo].[Notificaciones] ([OrdenFab], [Lote], [LoteSAP], [Equipo], [Inicio], [Fin], [Usuario], [FechaModificacion], [Producción], [Rechazo], [CausaRechazo]) VALUES (N'2055', 1, NULL, N'E-VIE-13', N'07:00', N'07:30', N'Fernando.Carrasco', N'06-10-2015 0:09:52', CAST(2000 AS Numeric(18, 0)), NULL, NULL)
INSERT [dbo].[Notificaciones] ([OrdenFab], [Lote], [LoteSAP], [Equipo], [Inicio], [Fin], [Usuario], [FechaModificacion], [Producción], [Rechazo], [CausaRechazo]) VALUES (N'2055', 2, NULL, N'E-VIE-13', N'08:00', N'08:30', N'Fernando.Carrasco', N'06-10-2015 0:13:36', CAST(2500 AS Numeric(18, 0)), NULL, NULL)
INSERT [dbo].[Notificaciones] ([OrdenFab], [Lote], [LoteSAP], [Equipo], [Inicio], [Fin], [Usuario], [FechaModificacion], [Producción], [Rechazo], [CausaRechazo]) VALUES (N'2072', 1, NULL, N'E-VIE-13', N'09:40', N'10:40', N'Fernando.Carrasco', N'29-10-2015 16:23:06', CAST(15000 AS Numeric(18, 0)), NULL, NULL)
INSERT [dbo].[Opciones] ([Opcion], [Descripción], [Modulo], [Estado], [tipo], [url], [tx]) VALUES (N'Areas', N'Areas', N'Config', N'Activo', N'Pagina', N'/Admin/Areas.aspx                                  ', NULL)
INSERT [dbo].[Opciones] ([Opcion], [Descripción], [Modulo], [Estado], [tipo], [url], [tx]) VALUES (N'Autorizaciones', N'Autorizaciones', N'Admin', N'Activo', N'Pagina', N'/Admin/Autorizaciones.aspx                         ', NULL)
INSERT [dbo].[Opciones] ([Opcion], [Descripción], [Modulo], [Estado], [tipo], [url], [tx]) VALUES (N'Causas Det', N'Causas Detención', N'Config', N'Activo', N'Pagina', N'/Admin/Causas_Detencion.aspx                       ', NULL)
INSERT [dbo].[Opciones] ([Opcion], [Descripción], [Modulo], [Estado], [tipo], [url], [tx]) VALUES (N'Centros', N'Centros', N'Config', N'Activo', N'Pagina', N'/Admin/Centros.aspx                                ', NULL)
INSERT [dbo].[Opciones] ([Opcion], [Descripción], [Modulo], [Estado], [tipo], [url], [tx]) VALUES (N'Cfg Planillas', N'Config. Planillas', N'Config', N'Activo', N'Pagina', N'/Admin/Configuracion_Planillas.aspx', NULL)
INSERT [dbo].[Opciones] ([Opcion], [Descripción], [Modulo], [Estado], [tipo], [url], [tx]) VALUES (N'Controles', N'Controles', N'Config', N'Activo', N'Menu', NULL, NULL)
INSERT [dbo].[Opciones] ([Opcion], [Descripción], [Modulo], [Estado], [tipo], [url], [tx]) VALUES (N'Detención', N'Detención', N'Detenciones', N'Activo', N'Pagina', N'/Detenciones/Detenciones.aspx', NULL)
INSERT [dbo].[Opciones] ([Opcion], [Descripción], [Modulo], [Estado], [tipo], [url], [tx]) VALUES (N'Detenciones', N'Detenciones', N'Config', N'Activo', N'Menu', NULL, NULL)
INSERT [dbo].[Opciones] ([Opcion], [Descripción], [Modulo], [Estado], [tipo], [url], [tx]) VALUES (N'Dotaciones', N'Dotaciones', N'Config', N'Activo', N'Menu', NULL, NULL)
INSERT [dbo].[Opciones] ([Opcion], [Descripción], [Modulo], [Estado], [tipo], [url], [tx]) VALUES (N'Equipos', N'Equipos', N'Config', N'Activo', N'Pagina', N'/Admin/Equipos.aspx                                ', NULL)
INSERT [dbo].[Opciones] ([Opcion], [Descripción], [Modulo], [Estado], [tipo], [url], [tx]) VALUES (N'Familia', N'Familias Producto', N'Config', N'Activo', N'Pagina', N'/Admin/Familias_Producto.aspx                      ', NULL)
INSERT [dbo].[Opciones] ([Opcion], [Descripción], [Modulo], [Estado], [tipo], [url], [tx]) VALUES (N'Formatos', N'Formatos', N'Config', N'Activo', N'Pagina', N'/Admin/Formatos.aspx                               ', NULL)
INSERT [dbo].[Opciones] ([Opcion], [Descripción], [Modulo], [Estado], [tipo], [url], [tx]) VALUES (N'Global', N'Global', N'Config', N'Activo', N'Menu', NULL, NULL)
INSERT [dbo].[Opciones] ([Opcion], [Descripción], [Modulo], [Estado], [tipo], [url], [tx]) VALUES (N'Incidentes', N'Incidentes', N'Config', N'Activo', N'Menu', NULL, NULL)
INSERT [dbo].[Opciones] ([Opcion], [Descripción], [Modulo], [Estado], [tipo], [url], [tx]) VALUES (N'Layout', N'Layout', N'Config', N'Activo', N'Menu', NULL, NULL)
INSERT [dbo].[Opciones] ([Opcion], [Descripción], [Modulo], [Estado], [tipo], [url], [tx]) VALUES (N'Marcas', N'Marcas', N'Config', N'Activo', N'Pagina', N'/Admin/Marcas.aspx                                 ', NULL)
INSERT [dbo].[Opciones] ([Opcion], [Descripción], [Modulo], [Estado], [tipo], [url], [tx]) VALUES (N'Materiales', N'Materiales', N'Config', N'Activo', N'Menu', NULL, NULL)
INSERT [dbo].[Opciones] ([Opcion], [Descripción], [Modulo], [Estado], [tipo], [url], [tx]) VALUES (N'Menus', N'Menus', N'Admin', N'Activo', N'Pagina', N'/Admin/Menus.aspx                                  ', NULL)
INSERT [dbo].[Opciones] ([Opcion], [Descripción], [Modulo], [Estado], [tipo], [url], [tx]) VALUES (N'ModIncidentes', N'Modificación Incidentes', N'Incidentes', N'Activo', N'Pagina', N'/Incidentes/Modificacion_Incidente.aspx', NULL)
INSERT [dbo].[Opciones] ([Opcion], [Descripción], [Modulo], [Estado], [tipo], [url], [tx]) VALUES (N'Módulos', N'Módulos', N'Admin', N'Activo', N'Pagina', N'/Admin/Modulos.aspx                                ', N'AD01')
INSERT [dbo].[Opciones] ([Opcion], [Descripción], [Modulo], [Estado], [tipo], [url], [tx]) VALUES (N'Notificacion', N'Notificación', N'Producción', N'Activo', N'Pagina', N'/Produccion/Notificacion.aspx', NULL)
INSERT [dbo].[Opciones] ([Opcion], [Descripción], [Modulo], [Estado], [tipo], [url], [tx]) VALUES (N'OF', N'Ordenes Fabricación', N'Planif', N'Activo', N'Pagina', N'/Planif/Ordenes_Fab.aspx                           ', NULL)
INSERT [dbo].[Opciones] ([Opcion], [Descripción], [Modulo], [Estado], [tipo], [url], [tx]) VALUES (N'Opciones', N'Opciones', N'Admin', N'Activo', N'Pagina', N'/Admin/Opciones.aspx                               ', NULL)
INSERT [dbo].[Opciones] ([Opcion], [Descripción], [Modulo], [Estado], [tipo], [url], [tx]) VALUES (N'Perfiles', N'Perfiles', N'Admin', N'Activo', N'Pagina', N'/Admin/Perfiles.aspx                               ', NULL)
INSERT [dbo].[Opciones] ([Opcion], [Descripción], [Modulo], [Estado], [tipo], [url], [tx]) VALUES (N'Plan Producción', N'Plan Producción', N'Planif', N'Activo', N'Pagina', N'/Planif/PlanProduccion.aspx', NULL)
INSERT [dbo].[Opciones] ([Opcion], [Descripción], [Modulo], [Estado], [tipo], [url], [tx]) VALUES (N'Plantas', N'Plantas', N'Config', N'Activo', N'Pagina', N'/Admin/Plantas.aspx                                ', NULL)
INSERT [dbo].[Opciones] ([Opcion], [Descripción], [Modulo], [Estado], [tipo], [url], [tx]) VALUES (N'Procesos', N'Procesos', N'Config', N'Activo', N'Pagina', N'/Admin/Procesos.aspx                               ', NULL)
INSERT [dbo].[Opciones] ([Opcion], [Descripción], [Modulo], [Estado], [tipo], [url], [tx]) VALUES (N'Productos', N'Productos', N'Config', N'Activo', N'Pagina', N'/Admin/Productos.aspx                              ', NULL)
INSERT [dbo].[Opciones] ([Opcion], [Descripción], [Modulo], [Estado], [tipo], [url], [tx]) VALUES (N'RDetFec', N'Detenciones por Fecha', N'Detenciones', N'Activo', N'Pagina', N'/Detenciones/reporte_detenciones.aspx', NULL)
INSERT [dbo].[Opciones] ([Opcion], [Descripción], [Modulo], [Estado], [tipo], [url], [tx]) VALUES (N'Reg Incidentes', N'Registro Incidentes', N'Incidentes', N'Activo', N'Pagina', N'/Incidentes/Registro Incidentes.aspx', NULL)
INSERT [dbo].[Opciones] ([Opcion], [Descripción], [Modulo], [Estado], [tipo], [url], [tx]) VALUES (N'Rep Incidentes', N'Incidentes por Fecha', N'Incidentes', N'Activo', N'Pagina', N'/Incidentes/Reporte_Incidentes.aspx', NULL)
INSERT [dbo].[Opciones] ([Opcion], [Descripción], [Modulo], [Estado], [tipo], [url], [tx]) VALUES (N'Secuencias', N'Secuencias', N'Config', N'Activo', N'Pagina', N'/Admin/Secuencias.aspx', NULL)
INSERT [dbo].[Opciones] ([Opcion], [Descripción], [Modulo], [Estado], [tipo], [url], [tx]) VALUES (N'TipoInci', N'Tipos Incidente', N'Config', N'Activo', N'Pagina', N'/Admin/Tipo_Incidente.aspx', NULL)
INSERT [dbo].[Opciones] ([Opcion], [Descripción], [Modulo], [Estado], [tipo], [url], [tx]) VALUES (N'Tipos Detencion', N'Tipos Detencion', N'Config', N'Activo', N'Pagina', N'/Admin/Tipos_Detencion.aspx                        ', NULL)
INSERT [dbo].[Opciones] ([Opcion], [Descripción], [Modulo], [Estado], [tipo], [url], [tx]) VALUES (N'Turnos', N'Turnos', N'Config', N'Activo', N'Pagina', N'/Admin/Turnos.aspx                                 ', NULL)
INSERT [dbo].[Opciones] ([Opcion], [Descripción], [Modulo], [Estado], [tipo], [url], [tx]) VALUES (N'Turnos x Planta', N'Turnos x Planta', N'Config', N'Activo', N'Pagina', N'/Admin/Turno_Planta.aspx                           ', NULL)
INSERT [dbo].[Opciones] ([Opcion], [Descripción], [Modulo], [Estado], [tipo], [url], [tx]) VALUES (N'Unidades', N'Unidades de Medida', N'Config', N'Activo', N'Pagina', N'/Admin/Unidades.aspx                               ', NULL)
INSERT [dbo].[Opciones] ([Opcion], [Descripción], [Modulo], [Estado], [tipo], [url], [tx]) VALUES (N'Usuario Fn', N'Funcion Usuario', N'Admin', N'Activo', N'Pagina', N'/Admin/UsuarioFuncion.aspx', NULL)
INSERT [dbo].[Opciones] ([Opcion], [Descripción], [Modulo], [Estado], [tipo], [url], [tx]) VALUES (N'Usuarios', N'Usuarios', N'Admin', N'Activo', N'Pagina', N'/Admin/Usuarios.aspx                               ', NULL)
INSERT [dbo].[Opciones] ([Opcion], [Descripción], [Modulo], [Estado], [tipo], [url], [tx]) VALUES (N'Variables', N'Variables', N'Config', N'Activo', N'Pagina', N'/Admin/Variables.aspx', NULL)
INSERT [dbo].[OrdenesFabricacion] ([OrdenFab], [FechaPlanif], [Area], [Turno], [Material], [CantidadPlanif], [TiempoPlanif], [CantidadReal], [TiempoReal], [Inicio], [Fin], [Prioridad], [Fecha Lote], [Observaciones], [Planificador], [Fecha Creación], [Fecha Modif], [EstadoOF]) VALUES (N'1004', N'2015-09-07', N'VIE03', N'VIE-1', N'1020', 300, CAST(200.0 AS Numeric(10, 1)), NULL, NULL, NULL, NULL, N'Media', N'2015-09-08', N'                                                   ', NULL, N'Sep 28 2015 10:36AM ', NULL, N'Planif')
INSERT [dbo].[OrdenesFabricacion] ([OrdenFab], [FechaPlanif], [Area], [Turno], [Material], [CantidadPlanif], [TiempoPlanif], [CantidadReal], [TiempoReal], [Inicio], [Fin], [Prioridad], [Fecha Lote], [Observaciones], [Planificador], [Fecha Creación], [Fecha Modif], [EstadoOF]) VALUES (N'1005', N'2015-09-08', N'VIE03', N'VIE-1', N'1020', 300, CAST(40.0 AS Numeric(10, 1)), NULL, NULL, NULL, NULL, N'Media', N'2015-09-09', N'                                                   ', NULL, N'Sep 28 2015 10:36AM ', NULL, N'Planif')
INSERT [dbo].[OrdenesFabricacion] ([OrdenFab], [FechaPlanif], [Area], [Turno], [Material], [CantidadPlanif], [TiempoPlanif], [CantidadReal], [TiempoReal], [Inicio], [Fin], [Prioridad], [Fecha Lote], [Observaciones], [Planificador], [Fecha Creación], [Fecha Modif], [EstadoOF]) VALUES (N'1006', N'2015-09-08', N'VIE03', N'VIE-1', N'1020', 1500, CAST(1.5 AS Numeric(10, 1)), NULL, NULL, NULL, NULL, N'Media', N'2015-09-09', N'                                                   ', NULL, N'Sep 28 2015 10:36AM ', NULL, N'Planif')
INSERT [dbo].[OrdenesFabricacion] ([OrdenFab], [FechaPlanif], [Area], [Turno], [Material], [CantidadPlanif], [TiempoPlanif], [CantidadReal], [TiempoReal], [Inicio], [Fin], [Prioridad], [Fecha Lote], [Observaciones], [Planificador], [Fecha Creación], [Fecha Modif], [EstadoOF]) VALUES (N'1007', N'2015-09-08', N'VIE03', N'VIE-1', N'1023', 5000, CAST(2.1 AS Numeric(10, 1)), NULL, NULL, NULL, NULL, N'Media', NULL, N'                                                   ', NULL, N'Sep 28 2015 10:36AM ', NULL, N'Planif')
INSERT [dbo].[OrdenesFabricacion] ([OrdenFab], [FechaPlanif], [Area], [Turno], [Material], [CantidadPlanif], [TiempoPlanif], [CantidadReal], [TiempoReal], [Inicio], [Fin], [Prioridad], [Fecha Lote], [Observaciones], [Planificador], [Fecha Creación], [Fecha Modif], [EstadoOF]) VALUES (N'1012', N'2015-09-07', N'VIE03', N'VIE-1', N'1020', 43000, CAST(44.0 AS Numeric(10, 1)), NULL, NULL, NULL, NULL, N'Media', N'2015-09-15', N'                                                   ', NULL, N'Sep 28 2015 10:36AM ', NULL, N'Planif')
INSERT [dbo].[OrdenesFabricacion] ([OrdenFab], [FechaPlanif], [Area], [Turno], [Material], [CantidadPlanif], [TiempoPlanif], [CantidadReal], [TiempoReal], [Inicio], [Fin], [Prioridad], [Fecha Lote], [Observaciones], [Planificador], [Fecha Creación], [Fecha Modif], [EstadoOF]) VALUES (N'1013', N'2015-09-07', N'VIE03', N'VIE-1', N'870', 15000, CAST(24.2 AS Numeric(10, 1)), NULL, NULL, NULL, NULL, N'Media', N'2015-09-08', N'                                                   ', NULL, N'Sep 28 2015 10:36AM ', NULL, N'Planif')
INSERT [dbo].[OrdenesFabricacion] ([OrdenFab], [FechaPlanif], [Area], [Turno], [Material], [CantidadPlanif], [TiempoPlanif], [CantidadReal], [TiempoReal], [Inicio], [Fin], [Prioridad], [Fecha Lote], [Observaciones], [Planificador], [Fecha Creación], [Fecha Modif], [EstadoOF]) VALUES (N'1014', N'2015-09-07', N'VIE03', N'VIE-1', N'1023', 10000, CAST(7.1 AS Numeric(10, 1)), NULL, NULL, NULL, NULL, N'Media', N'2015-09-08', N'                                                   ', NULL, N'Sep 28 2015 10:36AM ', NULL, N'Planif')
INSERT [dbo].[OrdenesFabricacion] ([OrdenFab], [FechaPlanif], [Area], [Turno], [Material], [CantidadPlanif], [TiempoPlanif], [CantidadReal], [TiempoReal], [Inicio], [Fin], [Prioridad], [Fecha Lote], [Observaciones], [Planificador], [Fecha Creación], [Fecha Modif], [EstadoOF]) VALUES (N'1015', N'2015-09-07', N'VIE03', N'VIE-1', N'870', 9000, CAST(14.5 AS Numeric(10, 1)), NULL, NULL, NULL, NULL, N'Alta', N'2015-09-10', N'                                                   ', NULL, N'Sep 28 2015 10:36AM ', NULL, N'Planif')
INSERT [dbo].[OrdenesFabricacion] ([OrdenFab], [FechaPlanif], [Area], [Turno], [Material], [CantidadPlanif], [TiempoPlanif], [CantidadReal], [TiempoReal], [Inicio], [Fin], [Prioridad], [Fecha Lote], [Observaciones], [Planificador], [Fecha Creación], [Fecha Modif], [EstadoOF]) VALUES (N'1016', N'2015-09-07', N'VIE03', N'VIE-1', N'1030', 5000, CAST(3.6 AS Numeric(10, 1)), NULL, NULL, NULL, NULL, N'Media', N'2015-09-09', N'                                                   ', NULL, N'Sep 28 2015 10:36AM ', NULL, N'Planif')
INSERT [dbo].[OrdenesFabricacion] ([OrdenFab], [FechaPlanif], [Area], [Turno], [Material], [CantidadPlanif], [TiempoPlanif], [CantidadReal], [TiempoReal], [Inicio], [Fin], [Prioridad], [Fecha Lote], [Observaciones], [Planificador], [Fecha Creación], [Fecha Modif], [EstadoOF]) VALUES (N'1026', N'2015-09-14', N'VIE03', N'VIE-1', N'1020', 20000, CAST(0.0 AS Numeric(10, 1)), NULL, NULL, NULL, NULL, N'Media', N'2015-09-17', NULL, NULL, N'Sep 28 2015 10:36AM ', NULL, N'Planif')
INSERT [dbo].[OrdenesFabricacion] ([OrdenFab], [FechaPlanif], [Area], [Turno], [Material], [CantidadPlanif], [TiempoPlanif], [CantidadReal], [TiempoReal], [Inicio], [Fin], [Prioridad], [Fecha Lote], [Observaciones], [Planificador], [Fecha Creación], [Fecha Modif], [EstadoOF]) VALUES (N'2006', N'2015-09-23', N'VIE03', N'VIE-1', N'1020', 12000, CAST(0.0 AS Numeric(10, 1)), NULL, NULL, NULL, NULL, N'Alta', N'2015-09-24', NULL, NULL, N'Sep 28 2015 10:36AM ', NULL, N'Planif')
INSERT [dbo].[OrdenesFabricacion] ([OrdenFab], [FechaPlanif], [Area], [Turno], [Material], [CantidadPlanif], [TiempoPlanif], [CantidadReal], [TiempoReal], [Inicio], [Fin], [Prioridad], [Fecha Lote], [Observaciones], [Planificador], [Fecha Creación], [Fecha Modif], [EstadoOF]) VALUES (N'2007', N'2015-09-23', N'VIE03', N'VIE-1', N'1021', 9000, CAST(9.2 AS Numeric(10, 1)), NULL, NULL, NULL, NULL, N'Media', N'', N'', NULL, N'Sep 28 2015 10:36AM ', NULL, N'Planif')
INSERT [dbo].[OrdenesFabricacion] ([OrdenFab], [FechaPlanif], [Area], [Turno], [Material], [CantidadPlanif], [TiempoPlanif], [CantidadReal], [TiempoReal], [Inicio], [Fin], [Prioridad], [Fecha Lote], [Observaciones], [Planificador], [Fecha Creación], [Fecha Modif], [EstadoOF]) VALUES (N'2015', N'2015-09-23', N'VIE03', N'VIE-2', N'1020', 13000, CAST(13.3 AS Numeric(10, 1)), NULL, NULL, NULL, NULL, N'Media', N'', N'', NULL, N'Sep 28 2015 10:36AM ', NULL, N'Planif')
INSERT [dbo].[OrdenesFabricacion] ([OrdenFab], [FechaPlanif], [Area], [Turno], [Material], [CantidadPlanif], [TiempoPlanif], [CantidadReal], [TiempoReal], [Inicio], [Fin], [Prioridad], [Fecha Lote], [Observaciones], [Planificador], [Fecha Creación], [Fecha Modif], [EstadoOF]) VALUES (N'2017', N'2015-09-29', N'VIE03', N'VIE-1', N'1020', 15000, CAST(15.3 AS Numeric(10, 1)), NULL, NULL, NULL, NULL, N'Media', N'13-09-2015 0:00:00', N'', NULL, N'Sep 28 2015 10:36AM ', NULL, N'Planif')
INSERT [dbo].[OrdenesFabricacion] ([OrdenFab], [FechaPlanif], [Area], [Turno], [Material], [CantidadPlanif], [TiempoPlanif], [CantidadReal], [TiempoReal], [Inicio], [Fin], [Prioridad], [Fecha Lote], [Observaciones], [Planificador], [Fecha Creación], [Fecha Modif], [EstadoOF]) VALUES (N'2018', N'2015-09-29', N'VIE03', N'VIE-1', N'1030', 15000, CAST(10.7 AS Numeric(10, 1)), NULL, NULL, NULL, NULL, N'Media', N'', N'', NULL, N'Sep 28 2015 10:36AM ', NULL, N'Planif')
INSERT [dbo].[OrdenesFabricacion] ([OrdenFab], [FechaPlanif], [Area], [Turno], [Material], [CantidadPlanif], [TiempoPlanif], [CantidadReal], [TiempoReal], [Inicio], [Fin], [Prioridad], [Fecha Lote], [Observaciones], [Planificador], [Fecha Creación], [Fecha Modif], [EstadoOF]) VALUES (N'2026', N'2015-09-29', N'VIE03', N'VIE-1', N'1020', 40000, CAST(40.9 AS Numeric(10, 1)), NULL, NULL, NULL, NULL, N'Alta', N'', N'', NULL, N'Sep 28 2015 10:36AM ', NULL, N'Planif')
INSERT [dbo].[OrdenesFabricacion] ([OrdenFab], [FechaPlanif], [Area], [Turno], [Material], [CantidadPlanif], [TiempoPlanif], [CantidadReal], [TiempoReal], [Inicio], [Fin], [Prioridad], [Fecha Lote], [Observaciones], [Planificador], [Fecha Creación], [Fecha Modif], [EstadoOF]) VALUES (N'2027', N'2015-09-29', N'VIE03', N'VIE-1', N'1030', 25000, CAST(17.9 AS Numeric(10, 1)), NULL, NULL, NULL, NULL, N'Alta', N'', N'', NULL, N'Sep 28 2015 10:36AM ', NULL, N'Planif')
INSERT [dbo].[OrdenesFabricacion] ([OrdenFab], [FechaPlanif], [Area], [Turno], [Material], [CantidadPlanif], [TiempoPlanif], [CantidadReal], [TiempoReal], [Inicio], [Fin], [Prioridad], [Fecha Lote], [Observaciones], [Planificador], [Fecha Creación], [Fecha Modif], [EstadoOF]) VALUES (N'2028', N'2015-09-29', N'VIE03', N'VIE-1', N'1023', 23000, CAST(16.4 AS Numeric(10, 1)), NULL, NULL, NULL, NULL, N'Media', N'', N'', NULL, N'Sep 28 2015 10:36AM ', NULL, N'Planif')
INSERT [dbo].[OrdenesFabricacion] ([OrdenFab], [FechaPlanif], [Area], [Turno], [Material], [CantidadPlanif], [TiempoPlanif], [CantidadReal], [TiempoReal], [Inicio], [Fin], [Prioridad], [Fecha Lote], [Observaciones], [Planificador], [Fecha Creación], [Fecha Modif], [EstadoOF]) VALUES (N'2029', N'2015-09-29', N'VIE03', N'VIE-1', N'1041', 5000, CAST(8.1 AS Numeric(10, 1)), NULL, NULL, NULL, NULL, N'Media', N'', N'', NULL, N'Sep 28 2015 10:36AM ', NULL, N'Planif')
INSERT [dbo].[OrdenesFabricacion] ([OrdenFab], [FechaPlanif], [Area], [Turno], [Material], [CantidadPlanif], [TiempoPlanif], [CantidadReal], [TiempoReal], [Inicio], [Fin], [Prioridad], [Fecha Lote], [Observaciones], [Planificador], [Fecha Creación], [Fecha Modif], [EstadoOF]) VALUES (N'2030', N'2015-09-29', N'VIE03', N'VIE-1', N'870', 10000, CAST(16.1 AS Numeric(10, 1)), NULL, NULL, NULL, NULL, N'Media', N'', N'', NULL, N'Sep 28 2015 10:36AM ', NULL, N'Planif')
INSERT [dbo].[OrdenesFabricacion] ([OrdenFab], [FechaPlanif], [Area], [Turno], [Material], [CantidadPlanif], [TiempoPlanif], [CantidadReal], [TiempoReal], [Inicio], [Fin], [Prioridad], [Fecha Lote], [Observaciones], [Planificador], [Fecha Creación], [Fecha Modif], [EstadoOF]) VALUES (N'2032', N'2015-09-28', N'VIE03', N'VIE-1', N'1020', 30000, CAST(30.7 AS Numeric(10, 1)), NULL, NULL, NULL, NULL, N'Alta', N'2015-09-29', N'', NULL, N'Sep 28 2015  4:44PM ', NULL, N'Planif')
INSERT [dbo].[OrdenesFabricacion] ([OrdenFab], [FechaPlanif], [Area], [Turno], [Material], [CantidadPlanif], [TiempoPlanif], [CantidadReal], [TiempoReal], [Inicio], [Fin], [Prioridad], [Fecha Lote], [Observaciones], [Planificador], [Fecha Creación], [Fecha Modif], [EstadoOF]) VALUES (N'2034', N'2015-09-30', N'VIE03', N'VIE-1', N'1020', 35000, CAST(35.8 AS Numeric(10, 1)), 5000, CAST(45.0 AS Numeric(10, 1)), NULL, NULL, N'Alta', N'', N'', NULL, N'Sep 30 2015  1:11PM ', NULL, N'Planif')
INSERT [dbo].[OrdenesFabricacion] ([OrdenFab], [FechaPlanif], [Area], [Turno], [Material], [CantidadPlanif], [TiempoPlanif], [CantidadReal], [TiempoReal], [Inicio], [Fin], [Prioridad], [Fecha Lote], [Observaciones], [Planificador], [Fecha Creación], [Fecha Modif], [EstadoOF]) VALUES (N'2035', N'2015-09-30', N'VIE03', N'VIE-1', N'1023', 15000, CAST(10.7 AS Numeric(10, 1)), NULL, NULL, NULL, NULL, N'Media', N'', N'', NULL, N'Sep 30 2015  1:11PM ', NULL, N'Planif')
INSERT [dbo].[OrdenesFabricacion] ([OrdenFab], [FechaPlanif], [Area], [Turno], [Material], [CantidadPlanif], [TiempoPlanif], [CantidadReal], [TiempoReal], [Inicio], [Fin], [Prioridad], [Fecha Lote], [Observaciones], [Planificador], [Fecha Creación], [Fecha Modif], [EstadoOF]) VALUES (N'2036', N'2015-09-30', N'VIE03', N'VIE-1', N'838', 10000, CAST(16.1 AS Numeric(10, 1)), NULL, NULL, NULL, NULL, N'Alta', N'', N'', NULL, N'Sep 30 2015  1:12PM ', NULL, N'Planif')
INSERT [dbo].[OrdenesFabricacion] ([OrdenFab], [FechaPlanif], [Area], [Turno], [Material], [CantidadPlanif], [TiempoPlanif], [CantidadReal], [TiempoReal], [Inicio], [Fin], [Prioridad], [Fecha Lote], [Observaciones], [Planificador], [Fecha Creación], [Fecha Modif], [EstadoOF]) VALUES (N'2037', N'2015-09-30', N'VIE03', N'VIE-1', N'1055', 12000, CAST(19.4 AS Numeric(10, 1)), NULL, NULL, NULL, NULL, N'Media', N'', N'ENCAJAR A BAJA VELOCIDAD', NULL, N'Sep 30 2015  9:48PM ', NULL, N'Planif')
INSERT [dbo].[OrdenesFabricacion] ([OrdenFab], [FechaPlanif], [Area], [Turno], [Material], [CantidadPlanif], [TiempoPlanif], [CantidadReal], [TiempoReal], [Inicio], [Fin], [Prioridad], [Fecha Lote], [Observaciones], [Planificador], [Fecha Creación], [Fecha Modif], [EstadoOF]) VALUES (N'2039', N'2015-10-01', N'VIE03', N'VIE-1', N'1020', 15000, CAST(15.3 AS Numeric(10, 1)), 14500, CAST(45.0 AS Numeric(10, 1)), NULL, NULL, N'Alta', N'', N'', NULL, N'Oct  1 2015  1:13PM ', NULL, N'Planif')
INSERT [dbo].[OrdenesFabricacion] ([OrdenFab], [FechaPlanif], [Area], [Turno], [Material], [CantidadPlanif], [TiempoPlanif], [CantidadReal], [TiempoReal], [Inicio], [Fin], [Prioridad], [Fecha Lote], [Observaciones], [Planificador], [Fecha Creación], [Fecha Modif], [EstadoOF]) VALUES (N'2040', N'2015-10-01', N'VIE03', N'VIE-1', N'1020', 12000, CAST(12.3 AS Numeric(10, 1)), 4000, CAST(50.0 AS Numeric(10, 1)), NULL, NULL, N'Media', N'', N'', NULL, N'Oct  1 2015  1:14PM ', NULL, N'Planif')
INSERT [dbo].[OrdenesFabricacion] ([OrdenFab], [FechaPlanif], [Area], [Turno], [Material], [CantidadPlanif], [TiempoPlanif], [CantidadReal], [TiempoReal], [Inicio], [Fin], [Prioridad], [Fecha Lote], [Observaciones], [Planificador], [Fecha Creación], [Fecha Modif], [EstadoOF]) VALUES (N'2041', N'2015-10-01', N'VIE03', N'VIE-1', N'1055', 30000, CAST(48.4 AS Numeric(10, 1)), NULL, NULL, NULL, NULL, N'Media', N'', N'', NULL, N'Oct  1 2015  1:14PM ', NULL, N'Planif')
INSERT [dbo].[OrdenesFabricacion] ([OrdenFab], [FechaPlanif], [Area], [Turno], [Material], [CantidadPlanif], [TiempoPlanif], [CantidadReal], [TiempoReal], [Inicio], [Fin], [Prioridad], [Fecha Lote], [Observaciones], [Planificador], [Fecha Creación], [Fecha Modif], [EstadoOF]) VALUES (N'2042', N'2015-10-01', N'VIE03', N'VIE-1', N'870', 6000, CAST(9.7 AS Numeric(10, 1)), NULL, NULL, NULL, NULL, N'Media', N'', N'', NULL, N'Oct  1 2015  1:14PM ', NULL, N'Planif')
INSERT [dbo].[OrdenesFabricacion] ([OrdenFab], [FechaPlanif], [Area], [Turno], [Material], [CantidadPlanif], [TiempoPlanif], [CantidadReal], [TiempoReal], [Inicio], [Fin], [Prioridad], [Fecha Lote], [Observaciones], [Planificador], [Fecha Creación], [Fecha Modif], [EstadoOF]) VALUES (N'2044', N'2015-10-01', N'VIE03', N'VIE-2', N'1030', 25000, CAST(17.9 AS Numeric(10, 1)), NULL, NULL, NULL, NULL, N'Media', N'', N'Etiquetar manualmente', NULL, N'Oct  1 2015  2:35PM ', NULL, N'Planif')
INSERT [dbo].[OrdenesFabricacion] ([OrdenFab], [FechaPlanif], [Area], [Turno], [Material], [CantidadPlanif], [TiempoPlanif], [CantidadReal], [TiempoReal], [Inicio], [Fin], [Prioridad], [Fecha Lote], [Observaciones], [Planificador], [Fecha Creación], [Fecha Modif], [EstadoOF]) VALUES (N'2045', N'2015-10-01', N'VIE03', N'VIE-2', N'1039', 7000, CAST(11.3 AS Numeric(10, 1)), NULL, NULL, NULL, NULL, N'Media', N'', N'', NULL, N'Oct  1 2015  2:35PM ', NULL, N'Planif')
INSERT [dbo].[OrdenesFabricacion] ([OrdenFab], [FechaPlanif], [Area], [Turno], [Material], [CantidadPlanif], [TiempoPlanif], [CantidadReal], [TiempoReal], [Inicio], [Fin], [Prioridad], [Fecha Lote], [Observaciones], [Planificador], [Fecha Creación], [Fecha Modif], [EstadoOF]) VALUES (N'2046', N'2015-10-01', N'VIE03', N'VIE-2', N'838', 8000, CAST(12.9 AS Numeric(10, 1)), NULL, NULL, NULL, NULL, N'Media', N'', N'', NULL, N'Oct  1 2015  2:35PM ', NULL, N'Planif')
INSERT [dbo].[OrdenesFabricacion] ([OrdenFab], [FechaPlanif], [Area], [Turno], [Material], [CantidadPlanif], [TiempoPlanif], [CantidadReal], [TiempoReal], [Inicio], [Fin], [Prioridad], [Fecha Lote], [Observaciones], [Planificador], [Fecha Creación], [Fecha Modif], [EstadoOF]) VALUES (N'2049', N'2015-10-01', N'VIE03', N'VIE-3', N'1057', 16000, CAST(25.8 AS Numeric(10, 1)), NULL, NULL, NULL, NULL, N'Media', N'2015-10-02', N'', NULL, N'Oct  1 2015  2:37PM ', NULL, N'Planif')
INSERT [dbo].[OrdenesFabricacion] ([OrdenFab], [FechaPlanif], [Area], [Turno], [Material], [CantidadPlanif], [TiempoPlanif], [CantidadReal], [TiempoReal], [Inicio], [Fin], [Prioridad], [Fecha Lote], [Observaciones], [Planificador], [Fecha Creación], [Fecha Modif], [EstadoOF]) VALUES (N'2050', N'2015-10-01', N'VIE03', N'VIE-3', N'1055', 4000, CAST(6.5 AS Numeric(10, 1)), NULL, NULL, NULL, NULL, N'Alta', N'', N'', NULL, N'Oct  1 2015  2:37PM ', NULL, N'Planif')
INSERT [dbo].[OrdenesFabricacion] ([OrdenFab], [FechaPlanif], [Area], [Turno], [Material], [CantidadPlanif], [TiempoPlanif], [CantidadReal], [TiempoReal], [Inicio], [Fin], [Prioridad], [Fecha Lote], [Observaciones], [Planificador], [Fecha Creación], [Fecha Modif], [EstadoOF]) VALUES (N'2051', N'2015-10-01', N'VIE03', N'VIE-1', N'1057', 9000, CAST(14.5 AS Numeric(10, 1)), NULL, NULL, NULL, NULL, N'Alta', N'', N'', NULL, N'Oct  1 2015  3:11PM ', NULL, N'Planif')
INSERT [dbo].[OrdenesFabricacion] ([OrdenFab], [FechaPlanif], [Area], [Turno], [Material], [CantidadPlanif], [TiempoPlanif], [CantidadReal], [TiempoReal], [Inicio], [Fin], [Prioridad], [Fecha Lote], [Observaciones], [Planificador], [Fecha Creación], [Fecha Modif], [EstadoOF]) VALUES (N'2053', N'2015-10-05', N'VIE03', N'VIE-1', N'1020', 25000, CAST(25.6 AS Numeric(10, 1)), 35000, CAST(80.0 AS Numeric(10, 1)), NULL, NULL, N'Media', N'', N'', NULL, N'Oct  5 2015 12:58PM ', NULL, N'Planif')
INSERT [dbo].[OrdenesFabricacion] ([OrdenFab], [FechaPlanif], [Area], [Turno], [Material], [CantidadPlanif], [TiempoPlanif], [CantidadReal], [TiempoReal], [Inicio], [Fin], [Prioridad], [Fecha Lote], [Observaciones], [Planificador], [Fecha Creación], [Fecha Modif], [EstadoOF]) VALUES (N'2055', N'2015-10-06', N'VIE03', N'VIE-1', N'1020', 9000, CAST(9.2 AS Numeric(10, 1)), 4500, CAST(60.0 AS Numeric(10, 1)), NULL, NULL, N'Media', N'', N'', NULL, N'Oct  6 2015 12:09AM ', NULL, N'Planif')
INSERT [dbo].[OrdenesFabricacion] ([OrdenFab], [FechaPlanif], [Area], [Turno], [Material], [CantidadPlanif], [TiempoPlanif], [CantidadReal], [TiempoReal], [Inicio], [Fin], [Prioridad], [Fecha Lote], [Observaciones], [Planificador], [Fecha Creación], [Fecha Modif], [EstadoOF]) VALUES (N'2057', N'2015-10-08', N'VIE03', N'VIE-1', N'1020', 6000, CAST(6.1 AS Numeric(10, 1)), 0, CAST(0.0 AS Numeric(10, 1)), NULL, NULL, N'Media', N'', N'', NULL, N'Oct  8 2015  3:20PM ', NULL, N'Planif')
INSERT [dbo].[OrdenesFabricacion] ([OrdenFab], [FechaPlanif], [Area], [Turno], [Material], [CantidadPlanif], [TiempoPlanif], [CantidadReal], [TiempoReal], [Inicio], [Fin], [Prioridad], [Fecha Lote], [Observaciones], [Planificador], [Fecha Creación], [Fecha Modif], [EstadoOF]) VALUES (N'2060', N'2015-10-28', N'VIE03', N'VIE-1', N'1020', 10000, CAST(10.2 AS Numeric(10, 1)), NULL, NULL, NULL, NULL, N'Media', N'2015-10-29', N'', NULL, N'Oct 27 2015 10:43AM ', NULL, N'Planif')
INSERT [dbo].[OrdenesFabricacion] ([OrdenFab], [FechaPlanif], [Area], [Turno], [Material], [CantidadPlanif], [TiempoPlanif], [CantidadReal], [TiempoReal], [Inicio], [Fin], [Prioridad], [Fecha Lote], [Observaciones], [Planificador], [Fecha Creación], [Fecha Modif], [EstadoOF]) VALUES (N'2062', N'2015-10-30', N'VIE03', N'VIE-1', N'1020', 10000, CAST(10.2 AS Numeric(10, 1)), NULL, NULL, NULL, NULL, N'Media', N'2015-10-29', N'', NULL, N'Oct 27 2015 10:43AM ', NULL, N'Planif')
INSERT [dbo].[OrdenesFabricacion] ([OrdenFab], [FechaPlanif], [Area], [Turno], [Material], [CantidadPlanif], [TiempoPlanif], [CantidadReal], [TiempoReal], [Inicio], [Fin], [Prioridad], [Fecha Lote], [Observaciones], [Planificador], [Fecha Creación], [Fecha Modif], [EstadoOF]) VALUES (N'2064', N'2015-11-02', N'VIE03', N'VIE-1', N'1020', 6000, CAST(6.1 AS Numeric(10, 1)), NULL, NULL, NULL, NULL, N'Media', N'2015-10-29', N'', NULL, N'Oct 27 2015 10:48AM ', NULL, N'Planif')
INSERT [dbo].[OrdenesFabricacion] ([OrdenFab], [FechaPlanif], [Area], [Turno], [Material], [CantidadPlanif], [TiempoPlanif], [CantidadReal], [TiempoReal], [Inicio], [Fin], [Prioridad], [Fecha Lote], [Observaciones], [Planificador], [Fecha Creación], [Fecha Modif], [EstadoOF]) VALUES (N'2065', N'2015-11-02', N'VIE03', N'VIE-1', N'1020', 15000, CAST(15.3 AS Numeric(10, 1)), NULL, NULL, NULL, NULL, N'Media', N'2015-10-29', N'', NULL, N'Oct 27 2015 10:49AM ', NULL, N'Planif')
INSERT [dbo].[OrdenesFabricacion] ([OrdenFab], [FechaPlanif], [Area], [Turno], [Material], [CantidadPlanif], [TiempoPlanif], [CantidadReal], [TiempoReal], [Inicio], [Fin], [Prioridad], [Fecha Lote], [Observaciones], [Planificador], [Fecha Creación], [Fecha Modif], [EstadoOF]) VALUES (N'2068', N'2015-10-27', N'VIE03', N'VIE-1', N'1020', 10000, CAST(10.2 AS Numeric(10, 1)), NULL, NULL, NULL, NULL, N'Media', N'2015-10-29', N'', NULL, N'Oct 27 2015 10:54AM ', NULL, N'Planif')
INSERT [dbo].[OrdenesFabricacion] ([OrdenFab], [FechaPlanif], [Area], [Turno], [Material], [CantidadPlanif], [TiempoPlanif], [CantidadReal], [TiempoReal], [Inicio], [Fin], [Prioridad], [Fecha Lote], [Observaciones], [Planificador], [Fecha Creación], [Fecha Modif], [EstadoOF]) VALUES (N'2069', N'2015-10-08', N'VIE03', N'VIE-1', N'1023', 9000, CAST(6.4 AS Numeric(10, 1)), NULL, NULL, NULL, NULL, N'Media', N'2015-10-29', N'', NULL, N'Oct 29 2015  4:20PM ', NULL, N'Planif')
INSERT [dbo].[OrdenesFabricacion] ([OrdenFab], [FechaPlanif], [Area], [Turno], [Material], [CantidadPlanif], [TiempoPlanif], [CantidadReal], [TiempoReal], [Inicio], [Fin], [Prioridad], [Fecha Lote], [Observaciones], [Planificador], [Fecha Creación], [Fecha Modif], [EstadoOF]) VALUES (N'2070', N'2015-10-30', N'VIE03', N'VIE-1', N'1020', 30000, CAST(30.7 AS Numeric(10, 1)), NULL, NULL, NULL, NULL, N'Media', N'', N'', NULL, N'Oct 29 2015  4:22PM ', NULL, N'Planif')
INSERT [dbo].[OrdenesFabricacion] ([OrdenFab], [FechaPlanif], [Area], [Turno], [Material], [CantidadPlanif], [TiempoPlanif], [CantidadReal], [TiempoReal], [Inicio], [Fin], [Prioridad], [Fecha Lote], [Observaciones], [Planificador], [Fecha Creación], [Fecha Modif], [EstadoOF]) VALUES (N'2072', N'2015-10-29', N'VIE03', N'VIE-1', N'1020', 30000, CAST(30.7 AS Numeric(10, 1)), 15000, CAST(60.0 AS Numeric(10, 1)), NULL, NULL, N'Media', N'2015-10-31', N'', NULL, N'Oct 29 2015  4:22PM ', NULL, N'Planif')
INSERT [dbo].[Perfiles] ([Perfil], [Descripción], [Estado]) VALUES (N'Administrador', N'Administrador', N'Activo')
INSERT [dbo].[Perfiles] ([Perfil], [Descripción], [Estado]) VALUES (N'OP-ENV-VIE', N'Operador Envasadora Vienesas', N'Activo')
INSERT [dbo].[PlanillasMedicionDet] ([NroPlanilla], [Linea], [Variable], [Obligatorio], [Lote], [Producto]) VALUES (1, 1, N'CCORT-ALK1', 1, 1, 1)
INSERT [dbo].[PlanillasMedicionDet] ([NroPlanilla], [Linea], [Variable], [Obligatorio], [Lote], [Producto]) VALUES (1, 2, N'CCORT-ALK2', 1, 1, 1)
INSERT [dbo].[PlanillasMedicionDet] ([NroPlanilla], [Linea], [Variable], [Obligatorio], [Lote], [Producto]) VALUES (1, 3, N'CCORT-JCON', 1, 1, 1)
INSERT [dbo].[PlanillasMedicionEnc] ([NroPlanilla], [Titulo], [Planta], [Area], [Proceso], [Equipo], [DiasToleranciaIng], [Estado]) VALUES (1, N'Control Temperatura Hornos', N'VIE', N'VIE02', N'PR-VIE-04', NULL, 0, N'Activo')
INSERT [dbo].[Plantas] ([Planta], [Descripción], [Fecha Creación], [Estado], [Centro]) VALUES (N'JAM', N'Jamones', NULL, N'Activo', N'P1')
INSERT [dbo].[Plantas] ([Planta], [Descripción], [Fecha Creación], [Estado], [Centro]) VALUES (N'PAT', N'Pate', NULL, N'Activo', N'P1')
INSERT [dbo].[Plantas] ([Planta], [Descripción], [Fecha Creación], [Estado], [Centro]) VALUES (N'PRR', N'Parrilleros', NULL, N'Activo', N'P1')
INSERT [dbo].[Plantas] ([Planta], [Descripción], [Fecha Creación], [Estado], [Centro]) VALUES (N'SAL', N'Salames', NULL, N'Activo', N'P1')
INSERT [dbo].[Plantas] ([Planta], [Descripción], [Fecha Creación], [Estado], [Centro]) VALUES (N'VIE', N'Vienesas', NULL, N'Activo', N'P1')
INSERT [dbo].[Procesos] ([Proceso], [Descripción], [Fecha Creación], [Estado], [Area]) VALUES (N'Proc-a', N'Proceso A', N'Oct 27 2015 12:57PM', N'Activo', N'VIE01')
INSERT [dbo].[Procesos] ([Proceso], [Descripción], [Fecha Creación], [Estado], [Area]) VALUES (N'PR-VIE-01', N'MEZCLADO', N'Aug 26 2015  3:04PM', N'Activo', N'VIE01')
INSERT [dbo].[Procesos] ([Proceso], [Descripción], [Fecha Creación], [Estado], [Area]) VALUES (N'PR-VIE-02', N'EMULSION', N'Aug 26 2015  3:15PM', N'Activo', N'VIE01')
INSERT [dbo].[Procesos] ([Proceso], [Descripción], [Fecha Creación], [Estado], [Area]) VALUES (N'PR-VIE-03', N'EMBUTIDO', N'Aug 26 2015  4:22PM', N'Activo', N'VIE02')
INSERT [dbo].[Procesos] ([Proceso], [Descripción], [Fecha Creación], [Estado], [Area]) VALUES (N'PR-VIE-04', N'COCCION', N'Aug 26 2015  4:22PM', N'Activo', N'VIE02')
INSERT [dbo].[Procesos] ([Proceso], [Descripción], [Fecha Creación], [Estado], [Area]) VALUES (N'PR-VIE-05', N'PELADO', NULL, N'Activo', N'VIE03')
INSERT [dbo].[Procesos] ([Proceso], [Descripción], [Fecha Creación], [Estado], [Area]) VALUES (N'PR-VIE-06', N'ENVASADO', N'Aug 26 2015  4:24PM', N'Activo', N'VIE03')
INSERT [dbo].[Procesos] ([Proceso], [Descripción], [Fecha Creación], [Estado], [Area]) VALUES (N'PR-VIE-07', N'ENCAJADO', N'Aug 26 2015  4:24PM', N'Activo', N'VIE03')
INSERT [dbo].[Productos] ([Material], [Producto], [CodigoMarca], [Planta], [Proceso], [CodigoFamilia], [IndSemielaborado], [PesoNeto], [PesoNetoCaja], [Estado], [Unidad], [Formato]) VALUES (N'1020', N'VIENESA 20 x 5 SJ', N'01', N'VIE', N'PR-VIE-06', N'01', N'No', CAST(0.25000 AS Numeric(10, 5)), CAST(5.00000 AS Numeric(10, 5)), N'Activo', N'Kg', N'250GR')
INSERT [dbo].[Productos] ([Material], [Producto], [CodigoMarca], [Planta], [Proceso], [CodigoFamilia], [IndSemielaborado], [PesoNeto], [PesoNetoCaja], [Estado], [Unidad], [Formato]) VALUES (N'1021', N'VIENESA 250G CUBA SJ', N'01', N'VIE', N'PR-VIE-06', N'01', N'No', CAST(0.25000 AS Numeric(10, 5)), CAST(5.00000 AS Numeric(10, 5)), N'Activo', N'Kg', N'250GR')
INSERT [dbo].[Productos] ([Material], [Producto], [CodigoMarca], [Planta], [Proceso], [CodigoFamilia], [IndSemielaborado], [PesoNeto], [PesoNetoCaja], [Estado], [Unidad], [Formato]) VALUES (N'1022', N'VIENESA 20x5 SJ.EXPORTACION MIX PERU', N'01', N'VIE', N'PR-VIE-06', N'01', N'No', CAST(0.25000 AS Numeric(10, 5)), CAST(5.00000 AS Numeric(10, 5)), N'Activo', N'Kg', N'250GR')
INSERT [dbo].[Productos] ([Material], [Producto], [CodigoMarca], [Planta], [Proceso], [CodigoFamilia], [IndSemielaborado], [PesoNeto], [PesoNetoCaja], [Estado], [Unidad], [Formato]) VALUES (N'1023', N'VIENESA PAVO 1 KG SJ', N'01', N'VIE', N'PR-VIE-06', N'01', N'No', CAST(1.00000 AS Numeric(10, 5)), CAST(5.00000 AS Numeric(10, 5)), N'Activo', N'Kg', N'KILO')
INSERT [dbo].[Productos] ([Material], [Producto], [CodigoMarca], [Planta], [Proceso], [CodigoFamilia], [IndSemielaborado], [PesoNeto], [PesoNetoCaja], [Estado], [Unidad], [Formato]) VALUES (N'1030', N'VIENESA VACIO 1 KG SJ', N'01', N'VIE', N'PR-VIE-06', N'01', N'No', CAST(1.00000 AS Numeric(10, 5)), CAST(5.00000 AS Numeric(10, 5)), N'Activo', N'Kg', N'KILO')
INSERT [dbo].[Productos] ([Material], [Producto], [CodigoMarca], [Planta], [Proceso], [CodigoFamilia], [IndSemielaborado], [PesoNeto], [PesoNetoCaja], [Estado], [Unidad], [Formato]) VALUES (N'1034', N'VIENESA VACIO 1 KG.SJ.EXPORT.MIX PERU', N'01', N'VIE', N'PR-VIE-06', N'01', N'No', CAST(1.00000 AS Numeric(10, 5)), CAST(5.00000 AS Numeric(10, 5)), N'Activo', N'Kg', N'MANUAL')
INSERT [dbo].[Productos] ([Material], [Producto], [CodigoMarca], [Planta], [Proceso], [CodigoFamilia], [IndSemielaborado], [PesoNeto], [PesoNetoCaja], [Estado], [Unidad], [Formato]) VALUES (N'1039', N'VIENESA POLLO 250 GRS. SJ.', N'01', N'VIE', N'PR-VIE-06', N'01', N'No', CAST(0.25000 AS Numeric(10, 5)), CAST(3.00000 AS Numeric(10, 5)), N'Activo', N'Kg', N'MANUAL')
INSERT [dbo].[Productos] ([Material], [Producto], [CodigoMarca], [Planta], [Proceso], [CodigoFamilia], [IndSemielaborado], [PesoNeto], [PesoNetoCaja], [Estado], [Unidad], [Formato]) VALUES (N'1040', N'VIENESA POLLO 250GRS.SJ.EXPORTACION PERU', N'01', N'VIE', N'PR-VIE-06', N'01', N'No', CAST(0.25000 AS Numeric(10, 5)), CAST(3.00000 AS Numeric(10, 5)), N'Activo', N'Kg', N'MANUAL')
INSERT [dbo].[Productos] ([Material], [Producto], [CodigoMarca], [Planta], [Proceso], [CodigoFamilia], [IndSemielaborado], [PesoNeto], [PesoNetoCaja], [Estado], [Unidad], [Formato]) VALUES (N'1041', N'VIENESA DE POLLO KILO SJ.', N'01', N'VIE', N'PR-VIE-06', N'01', N'No', CAST(1.00000 AS Numeric(10, 5)), CAST(5.00000 AS Numeric(10, 5)), N'Activo', N'Kg', N'MANUAL')
INSERT [dbo].[Productos] ([Material], [Producto], [CodigoMarca], [Planta], [Proceso], [CodigoFamilia], [IndSemielaborado], [PesoNeto], [PesoNetoCaja], [Estado], [Unidad], [Formato]) VALUES (N'1045', N'VIENESA DE POLLO KIL SJ.EXPORTACION PERU', N'01', N'VIE', N'PR-VIE-06', N'01', N'No', CAST(1.00000 AS Numeric(10, 5)), CAST(5.00000 AS Numeric(10, 5)), N'Activo', N'Kg', N'MANUAL')
INSERT [dbo].[Productos] ([Material], [Producto], [CodigoMarca], [Planta], [Proceso], [CodigoFamilia], [IndSemielaborado], [PesoNeto], [PesoNetoCaja], [Estado], [Unidad], [Formato]) VALUES (N'1055', N'VIENESA COLONIAL SAN JORGE 12x250 g. (5u', N'01', N'VIE', N'PR-VIE-06', N'01', N'No', CAST(0.25000 AS Numeric(10, 5)), CAST(3.00000 AS Numeric(10, 5)), N'Activo', N'Kg', N'MANUAL')
INSERT [dbo].[Productos] ([Material], [Producto], [CodigoMarca], [Planta], [Proceso], [CodigoFamilia], [IndSemielaborado], [PesoNeto], [PesoNetoCaja], [Estado], [Unidad], [Formato]) VALUES (N'1057', N'VIENESA COLONIAL SAN JORGE 5x1 KG.(20u)', N'04', N'VIE', N'PR-VIE-06', N'01', N'No', CAST(1.00000 AS Numeric(10, 5)), CAST(5.00000 AS Numeric(10, 5)), N'Activo', N'Kg', N'MANUAL')
INSERT [dbo].[Productos] ([Material], [Producto], [CodigoMarca], [Planta], [Proceso], [CodigoFamilia], [IndSemielaborado], [PesoNeto], [PesoNetoCaja], [Estado], [Unidad], [Formato]) VALUES (N'1415', N'CHORIPAN 4 UNIDADES SJ', N'01', N'VIE', N'PR-VIE-06', N'01', N'No', CAST(0.32000 AS Numeric(10, 5)), CAST(5.12000 AS Numeric(10, 5)), N'Activo', N'Kg', N'MANUAL')
INSERT [dbo].[Productos] ([Material], [Producto], [CodigoMarca], [Planta], [Proceso], [CodigoFamilia], [IndSemielaborado], [PesoNeto], [PesoNetoCaja], [Estado], [Unidad], [Formato]) VALUES (N'1450', N'LONGAN-CHORIPAN 3 KG SJ', N'01', N'VIE', N'PR-VIE-06', N'01', N'No', CAST(3.00000 AS Numeric(10, 5)), CAST(0.00000 AS Numeric(10, 5)), N'Activo', N'Kg', N'MANUAL')
INSERT [dbo].[Productos] ([Material], [Producto], [CodigoMarca], [Planta], [Proceso], [CodigoFamilia], [IndSemielaborado], [PesoNeto], [PesoNetoCaja], [Estado], [Unidad], [Formato]) VALUES (N'1890', N'EXTRA DOG 6 UNID. SJ', N'01', N'VIE', N'PR-VIE-06', N'01', N'No', CAST(0.57000 AS Numeric(10, 5)), CAST(5.70000 AS Numeric(10, 5)), N'Activo', N'Kg', N'MANUAL')
INSERT [dbo].[Productos] ([Material], [Producto], [CodigoMarca], [Planta], [Proceso], [CodigoFamilia], [IndSemielaborado], [PesoNeto], [PesoNetoCaja], [Estado], [Unidad], [Formato]) VALUES (N'2310', N'SALCHICHA DE PAVO 6x20 UNID.SOPRAVAL', N'09', N'VIE', N'PR-VIE-06', N'01', N'No', CAST(1.00000 AS Numeric(10, 5)), CAST(6.00000 AS Numeric(10, 5)), N'Activo', N'Kg', N'MANUAL')
INSERT [dbo].[Productos] ([Material], [Producto], [CodigoMarca], [Planta], [Proceso], [CodigoFamilia], [IndSemielaborado], [PesoNeto], [PesoNetoCaja], [Estado], [Unidad], [Formato]) VALUES (N'2315', N'SALCHICHA DE PAVO 12x5 UNID.SOPRAVAL', N'09', N'VIE', N'PR-VIE-06', N'01', N'No', CAST(0.25000 AS Numeric(10, 5)), CAST(3.00000 AS Numeric(10, 5)), N'Activo', N'Kg', N'MANUAL')
INSERT [dbo].[Productos] ([Material], [Producto], [CodigoMarca], [Planta], [Proceso], [CodigoFamilia], [IndSemielaborado], [PesoNeto], [PesoNetoCaja], [Estado], [Unidad], [Formato]) VALUES (N'838', N'VIENESAS E DOG 12 U EXP SJ', N'01', N'VIE', N'PR-VIE-06', N'01', N'No', CAST(1.16000 AS Numeric(10, 5)), CAST(5.80000 AS Numeric(10, 5)), N'Activo', N'Kg', N'MANUAL')
INSERT [dbo].[Productos] ([Material], [Producto], [CodigoMarca], [Planta], [Proceso], [CodigoFamilia], [IndSemielaborado], [PesoNeto], [PesoNetoCaja], [Estado], [Unidad], [Formato]) VALUES (N'870', N'VIENESA 17 CMS 4 KG SJ', N'01', N'VIE', N'PR-VIE-06', N'01', N'No', CAST(4.15000 AS Numeric(10, 5)), CAST(0.00000 AS Numeric(10, 5)), N'Activo', N'Kg', N'MANUAL')
INSERT [dbo].[Productos] ([Material], [Producto], [CodigoMarca], [Planta], [Proceso], [CodigoFamilia], [IndSemielaborado], [PesoNeto], [PesoNetoCaja], [Estado], [Unidad], [Formato]) VALUES (N'875', N'VIENESA 17 CM S/HUMO SJ', N'01', N'VIE', N'PR-VIE-06', N'01', N'No', CAST(4.24600 AS Numeric(10, 5)), CAST(0.00000 AS Numeric(10, 5)), N'Activo', N'Kg', N'MANUAL')
INSERT [dbo].[Productos] ([Material], [Producto], [CodigoMarca], [Planta], [Proceso], [CodigoFamilia], [IndSemielaborado], [PesoNeto], [PesoNetoCaja], [Estado], [Unidad], [Formato]) VALUES (N'904', N'VIENESA PAVO 5 UNIDADES CAJA 3 KG SJ', N'01', N'VIE', N'PR-VIE-06', N'01', N'No', CAST(0.25000 AS Numeric(10, 5)), CAST(3.00000 AS Numeric(10, 5)), N'Activo', N'Kg', N'MANUAL')
INSERT [dbo].[Secuencias] ([tipo], [inicial], [actual], [incremento], [fechaUltAct]) VALUES (N'DETEN', 10000, 10020, 1, CAST(N'2015-10-29 16:24:47.953' AS DateTime))
INSERT [dbo].[Secuencias] ([tipo], [inicial], [actual], [incremento], [fechaUltAct]) VALUES (N'INCID', 7000, 7012, 1, CAST(N'2015-10-29 16:25:45.553' AS DateTime))
INSERT [dbo].[Secuencias] ([tipo], [inicial], [actual], [incremento], [fechaUltAct]) VALUES (N'OF', 2000, 2072, 1, CAST(N'2015-10-29 16:22:37.860' AS DateTime))
INSERT [dbo].[TipoDetencion] ([Tipo], [Descripción], [Estado]) VALUES (N'11', N'Aseo', N'Activo')
INSERT [dbo].[TipoDetencion] ([Tipo], [Descripción], [Estado]) VALUES (N'12', N'M.Autónoma', N'Activo')
INSERT [dbo].[TipoDetencion] ([Tipo], [Descripción], [Estado]) VALUES (N'16', N'Operación', N'Activo')
INSERT [dbo].[TipoDetencion] ([Tipo], [Descripción], [Estado]) VALUES (N'24', N'Mantención', N'Activo')
INSERT [dbo].[TipoDetencion] ([Tipo], [Descripción], [Estado]) VALUES (N'25', N'Otros', N'Activo')
INSERT [dbo].[TipoDetencion] ([Tipo], [Descripción], [Estado]) VALUES (N'26', N'Planificación', N'Activo')
INSERT [dbo].[TipoDetencion] ([Tipo], [Descripción], [Estado]) VALUES (N'27', N'Producción', N'Activo')
INSERT [dbo].[TipoDetencion] ([Tipo], [Descripción], [Estado]) VALUES (N'29', N'Seguridad', N'Activo')
INSERT [dbo].[TiposIncidentes] ([TipoInicidente], [Descripcion], [Estado], [emailAlerta]) VALUES (N'MANT', N'Mantención', N'Activo', N'fernando.carrasco@gtia.cl')
INSERT [dbo].[TiposIncidentes] ([TipoInicidente], [Descripcion], [Estado], [emailAlerta]) VALUES (N'OPER', N'Operaciones', N'Activo', N'fernando.carrasco@gtia.cl')
INSERT [dbo].[TiposIncidentes] ([TipoInicidente], [Descripcion], [Estado], [emailAlerta]) VALUES (N'OTRS', N'Otros', N'Activo', N'fernando.carrasco@gtia.cl')
INSERT [dbo].[TiposIncidentes] ([TipoInicidente], [Descripcion], [Estado], [emailAlerta]) VALUES (N'PLAN', N'Planificación', N'Activo', N'fernando.carrasco@gtia.cl')
INSERT [dbo].[TiposIncidentes] ([TipoInicidente], [Descripcion], [Estado], [emailAlerta]) VALUES (N'RRHH', N'Personal', N'Activo', N'fernando.carrasco@gtia.cl')
INSERT [dbo].[TiposIncidentes] ([TipoInicidente], [Descripcion], [Estado], [emailAlerta]) VALUES (N'SEGU', N'Seguridad', N'Activo', N'fernando.carrasco@gtia.cl')
INSERT [dbo].[TurnoPlanta] ([Codigo], [Descripción], [Planta], [Turno], [HoraInicio], [HoraFin], [DotacionStd], [Fecha Creación], [Estado]) VALUES (N'VIE-1', N'Turno Día', N'VIE', N'Día', N'7:00', N'14:30', 72, NULL, N'Activo')
INSERT [dbo].[TurnoPlanta] ([Codigo], [Descripción], [Planta], [Turno], [HoraInicio], [HoraFin], [DotacionStd], [Fecha Creación], [Estado]) VALUES (N'VIE-2', N'Turno Tarde', N'VIE', N'Tarde', N'14:15', N'22:15', 72, NULL, N'Activo')
INSERT [dbo].[TurnoPlanta] ([Codigo], [Descripción], [Planta], [Turno], [HoraInicio], [HoraFin], [DotacionStd], [Fecha Creación], [Estado]) VALUES (N'VIE-3', N'Turno Noche', N'VIE', N'Noche', N'22:00', N'7:00', 72, NULL, N'Activo')
INSERT [dbo].[Turnos] ([Turno]) VALUES (N'Día')
INSERT [dbo].[Turnos] ([Turno]) VALUES (N'Noche')
INSERT [dbo].[Turnos] ([Turno]) VALUES (N'Tarde')
INSERT [dbo].[Unidades] ([Unidad], [Descripcion], [Fecha Creación], [Estado], [Tipo]) VALUES (N'°C', N'°C', N'Sep 21 2015  4:17PM', N'Activo', N'Proceso')
INSERT [dbo].[Unidades] ([Unidad], [Descripcion], [Fecha Creación], [Estado], [Tipo]) VALUES (N'Kg', N'Kilos', N'Aug 28 2015  1:52PM', N'Activo', N'Producto')
INSERT [dbo].[Unidades] ([Unidad], [Descripcion], [Fecha Creación], [Estado], [Tipo]) VALUES (N'Un', N'Unidad', N'Aug 28 2015  1:52PM', N'Activo', N'Producto')
INSERT [dbo].[UsuarioFuncion] ([Usuario], [Funcion], [Area], [Turno], [Proceso], [Equipo], [NivelRegDetencion], [DiasAtrasoReg]) VALUES (N'Andres.Ulloa', N'Operador Envasadora', N'VIE03', N'VIE-1', N'PR-VIE-06', N'E-VIE-15', N'Area', 3)
INSERT [dbo].[UsuarioFuncion] ([Usuario], [Funcion], [Area], [Turno], [Proceso], [Equipo], [NivelRegDetencion], [DiasAtrasoReg]) VALUES (N'Fernando.Carrasco', N'Operador Envasadora', N'VIE03', N'VIE-1', N'PR-VIE-06', N'E-VIE-13', N'Area', 3)
INSERT [dbo].[UsuarioFuncion] ([Usuario], [Funcion], [Area], [Turno], [Proceso], [Equipo], [NivelRegDetencion], [DiasAtrasoReg]) VALUES (N'op01', N'Operador Envasadora', N'VIE03', N'VIE-1', N'PR-VIE-06', N'E-VIE-14', N'Planta', 0)
INSERT [dbo].[Usuarios] ([Usuario], [Nombre], [eMail], [Pass], [Fecha Creación], [Estado], [UsuarioAD], [DominioAD], [Perfil], [Expiracion]) VALUES (N'Administrador', N'Administrador', N'administrador@cialalimentos.cl', N'cial1601', N'Sep  3 2015  3:34PM', N'Activo', N'Administrador', N'SANJORGE.CL', N'Administrador', N'2020-12-31')
INSERT [dbo].[Usuarios] ([Usuario], [Nombre], [eMail], [Pass], [Fecha Creación], [Estado], [UsuarioAD], [DominioAD], [Perfil], [Expiracion]) VALUES (N'Andres.Ulloa', N'Andres Ulloa', N'andres.ulloa@gtia.cl', N'g1t2i3a4', N'Sep 28 2015  3:09PM', N'Activo', NULL, N' ', N'Administrador', N'2017-09-30')
INSERT [dbo].[Usuarios] ([Usuario], [Nombre], [eMail], [Pass], [Fecha Creación], [Estado], [UsuarioAD], [DominioAD], [Perfil], [Expiracion]) VALUES (N'Fernando.Carrasco', N'Fernando Carrasco', N'fernando.carrasco@gtia.cl', N'k1i2n3o4', NULL, N'Activo', N'Fernando.Carrasco', N'SANJORGE1', N'Administrador', N'2020-12-31')
INSERT [dbo].[Usuarios] ([Usuario], [Nombre], [eMail], [Pass], [Fecha Creación], [Estado], [UsuarioAD], [DominioAD], [Perfil], [Expiracion]) VALUES (N'op01', N'Operador Envasadora', N'operador@cialalimentos.cl', N'1234', N'Sep 30 2015  8:14PM', N'Activo', NULL, N' ', N'OP-ENV-VIE', N'2027-01-03')
INSERT [dbo].[Variables] ([Variable], [Equipo], [Descripcion], [Unidad], [LimSup], [LimInf], [Fecha Creación], [Estado]) VALUES (N'CCORT-ALK1', N'E-VIE-11', N'Cantidad Cortada Horno Alkar#1', N'Un', NULL, NULL, N'Sep 21 2015  4:30PM ', N'Activo')
INSERT [dbo].[Variables] ([Variable], [Equipo], [Descripcion], [Unidad], [LimSup], [LimInf], [Fecha Creación], [Estado]) VALUES (N'CCORT-ALK2', N'E-VIE-12', N'Cantidad Cortada Horno Alkar#2', N'Un', NULL, NULL, N'Sep 21 2015  4:30PM ', N'Activo')
INSERT [dbo].[Variables] ([Variable], [Equipo], [Descripcion], [Unidad], [LimSup], [LimInf], [Fecha Creación], [Estado]) VALUES (N'CCORT-JCON', N'E-VIE-10', N'Cantidad Cortada Horno J-CON', N'Un', NULL, NULL, N'Sep 21 2015  4:31PM ', N'Activo')
INSERT [dbo].[Variables] ([Variable], [Equipo], [Descripcion], [Unidad], [LimSup], [LimInf], [Fecha Creación], [Estado]) VALUES (N'CLGS-ALK1', N'E-VIE-11', N'Cuelgas Horno Alkar#1', N'Un', NULL, NULL, N'Sep 21 2015  4:27PM ', N'Activo')
INSERT [dbo].[Variables] ([Variable], [Equipo], [Descripcion], [Unidad], [LimSup], [LimInf], [Fecha Creación], [Estado]) VALUES (N'CLGS-ALK2', N'E-VIE-12', N'Cuelgas Horno Alkar#2', N'Un', NULL, NULL, N'Sep 21 2015  4:28PM ', N'Activo')
INSERT [dbo].[Variables] ([Variable], [Equipo], [Descripcion], [Unidad], [LimSup], [LimInf], [Fecha Creación], [Estado]) VALUES (N'CLGS-J-CON', N'E-VIE-10', N'Cuelgas Horno J-CON', N'Un', NULL, NULL, N'Sep 21 2015  4:29PM ', N'Activo')
INSERT [dbo].[Variables] ([Variable], [Equipo], [Descripcion], [Unidad], [LimSup], [LimInf], [Fecha Creación], [Estado]) VALUES (N'NL211-PESO', N'NL21-1', N'Control Peso Embutidora #1', N'Kg', NULL, NULL, N'Sep 21 2015  5:00PM ', N'Activo')
INSERT [dbo].[Variables] ([Variable], [Equipo], [Descripcion], [Unidad], [LimSup], [LimInf], [Fecha Creación], [Estado]) VALUES (N'NL212-PESO', N'NL21-2', N'Control Peso Embutidora #2', N'Kg', NULL, NULL, N'Sep 21 2015  5:00PM ', N'Activo')
INSERT [dbo].[Variables] ([Variable], [Equipo], [Descripcion], [Unidad], [LimSup], [LimInf], [Fecha Creación], [Estado]) VALUES (N'NL213-PESO', N'NL21-3', N'Control Peso Embutidora #3', N'Kg', NULL, NULL, N'Sep 21 2015  5:01PM ', N'Activo')
INSERT [dbo].[Variables] ([Variable], [Equipo], [Descripcion], [Unidad], [LimSup], [LimInf], [Fecha Creación], [Estado]) VALUES (N'NL214-PESO', N'NL21-4', N'Control Peso Embutidora #4', N'Kg', NULL, NULL, N'Sep 21 2015  5:02PM ', N'Activo')
INSERT [dbo].[Variables] ([Variable], [Equipo], [Descripcion], [Unidad], [LimSup], [LimInf], [Fecha Creación], [Estado]) VALUES (N'TEMP-ALK1', N'E-VIE-11', N'Temperatura Horno Alkar#1', N'°C', CAST(72.0000 AS Numeric(18, 4)), NULL, N'Sep 21 2015  4:24PM ', N'Activo')
INSERT [dbo].[Variables] ([Variable], [Equipo], [Descripcion], [Unidad], [LimSup], [LimInf], [Fecha Creación], [Estado]) VALUES (N'TEMP-ALK2', N'E-VIE-12', N'Temperatura Horno Alkar#2', N'°C', CAST(72.0000 AS Numeric(18, 4)), NULL, N'Sep 21 2015  4:25PM ', N'Activo')
INSERT [dbo].[Variables] ([Variable], [Equipo], [Descripcion], [Unidad], [LimSup], [LimInf], [Fecha Creación], [Estado]) VALUES (N'TEMP-J-CON', N'E-VIE-10', N'Temperatura Horno J-CON', N'°C', CAST(72.0000 AS Numeric(18, 4)), NULL, N'Sep 21 2015  4:18PM ', N'Activo')
ALTER TABLE [dbo].[Areas]  WITH CHECK ADD  CONSTRAINT [FK_Areas_Plantas] FOREIGN KEY([Planta])
REFERENCES [dbo].[Plantas] ([Planta])
GO
ALTER TABLE [dbo].[Areas] CHECK CONSTRAINT [FK_Areas_Plantas]
GO
ALTER TABLE [dbo].[Formatos]  WITH CHECK ADD  CONSTRAINT [FK_Formatos_FamiliaProductos] FOREIGN KEY([CodigoFamilia])
REFERENCES [dbo].[FamiliaProductos] ([Codigo])
GO
ALTER TABLE [dbo].[Formatos] CHECK CONSTRAINT [FK_Formatos_FamiliaProductos]
GO
ALTER TABLE [dbo].[GanttTasks]  WITH CHECK ADD  CONSTRAINT [FK_GanttTasks_GanttTasks] FOREIGN KEY([ParentID])
REFERENCES [dbo].[GanttTasks] ([ID])
GO
ALTER TABLE [dbo].[GanttTasks] CHECK CONSTRAINT [FK_GanttTasks_GanttTasks]
GO
ALTER TABLE [dbo].[Plantas]  WITH CHECK ADD  CONSTRAINT [FK_Plantas_Centros] FOREIGN KEY([Centro])
REFERENCES [dbo].[Centros] ([Centro])
GO
ALTER TABLE [dbo].[Plantas] CHECK CONSTRAINT [FK_Plantas_Centros]
GO
ALTER TABLE [dbo].[Procesos]  WITH CHECK ADD  CONSTRAINT [FK_Procesos_Areas] FOREIGN KEY([Area])
REFERENCES [dbo].[Areas] ([Area])
GO
ALTER TABLE [dbo].[Procesos] CHECK CONSTRAINT [FK_Procesos_Areas]
GO
/****** Object:  StoredProcedure [dbo].[p_detenciones_usuario]    Script Date: 29-10-2015 22:30:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Script for SelectTopNRows command from SSMS  ******/
CREATE PROCEDURE [dbo].[p_detenciones_usuario]
@usuario varchar(50)
as
BEGIN
	SET NOCOUNT ON;
	declare @diasAtras INT

	SELECT @diasAtras = DiasAtrasoReg from UsuarioFuncion
	WHERE Usuario=@usuario

	SELECT [NroDetencion]
		  ,[Equipo]
		  ,[CodigoCausaPrimario]
		  ,[CodigoCausaSecundario]
		  ,[FechaDetencion]
		  ,[InicioDetencion]
		  ,[FinDetencion]
		  ,[Observaciones]
		  ,[Usuario]
		  ,[FechaGrabacion]
	  FROM [BopDB].[dbo].[Detenciones]
	  WHERE Usuario = @usuario and Convert(datetime,FechaDetencion,105)>=getdate()-@diasAtras
	  ORDER BY NroDetencion Desc
END
GO
/****** Object:  StoredProcedure [dbo].[p_eliminaOF]    Script Date: 29-10-2015 22:30:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[p_eliminaOF]
	-- Add the parameters for the stored procedure here
	@OF varchar(15),
	@Lote int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
 DELETE FROM Notificaciones where OrdenFab=@OF and Lote=@Lote
END

GO
/****** Object:  StoredProcedure [dbo].[p_equiposDetencion]    Script Date: 29-10-2015 22:30:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[p_equiposDetencion]
	-- Add the parameters for the stored procedure here
	@nivel varchar(10), 
	@localizacion varchar(10)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	IF @nivel = 'Planta'
	SELECT        Equipos.Equipo, Equipos.Descripción
				FROM            Equipos INNER JOIN
                         Procesos ON Equipos.Proceso = Procesos.Proceso INNER JOIN
                         Areas ON Procesos.Area = Areas.Area INNER JOIN
                         Plantas ON Areas.Planta = Plantas.Planta
				WHERE Plantas.Planta = @localizacion

	IF @nivel = 'Area'
	SELECT        Equipos.Equipo, Equipos.Descripción
				FROM            Equipos INNER JOIN
                         Procesos ON Equipos.Proceso = Procesos.Proceso INNER JOIN
                         Areas ON Procesos.Area = Areas.Area INNER JOIN
                         Plantas ON Areas.Planta = Plantas.Planta
				WHERE Areas.Area = @localizacion

	IF @nivel = 'Proceso'
	SELECT        Equipos.Equipo, Equipos.Descripción
				FROM            Equipos INNER JOIN
                         Procesos ON Equipos.Proceso = Procesos.Proceso INNER JOIN
                         Areas ON Procesos.Area = Areas.Area INNER JOIN
                         Plantas ON Areas.Planta = Plantas.Planta
				WHERE Procesos.Proceso = @localizacion
	IF @nivel = 'Equipo'
	SELECT        Equipos.Equipo, Equipos.Descripción
				FROM            Equipos INNER JOIN
                         Procesos ON Equipos.Proceso = Procesos.Proceso INNER JOIN
                         Areas ON Procesos.Area = Areas.Area INNER JOIN
                         Plantas ON Areas.Planta = Plantas.Planta
				WHERE Equipos.Equipo = @localizacion

END

GO
/****** Object:  StoredProcedure [dbo].[p_equiposIncidente]    Script Date: 29-10-2015 22:30:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[p_equiposIncidente]
	-- Add the parameters for the stored procedure here
	@nivel varchar(10), 
	@localizacion varchar(10)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	IF @nivel = 'Planta'
	SELECT '' as Equipo, 'N/A' as Descripción
	UNION
	SELECT        Equipos.Equipo, Equipos.Descripción
				FROM            Equipos INNER JOIN
                         Procesos ON Equipos.Proceso = Procesos.Proceso INNER JOIN
                         Areas ON Procesos.Area = Areas.Area INNER JOIN
                         Plantas ON Areas.Planta = Plantas.Planta
				WHERE Plantas.Planta = @localizacion

	IF @nivel = 'Area'
	SELECT '' as Equipo, 'N/A' as Descripción
	UNION
	SELECT        Equipos.Equipo, Equipos.Descripción
				FROM            Equipos INNER JOIN
                         Procesos ON Equipos.Proceso = Procesos.Proceso INNER JOIN
                         Areas ON Procesos.Area = Areas.Area INNER JOIN
                         Plantas ON Areas.Planta = Plantas.Planta
				WHERE Areas.Area = @localizacion

	IF @nivel = 'Proceso'
	SELECT '' as Equipo, 'N/A' as Descripción
	UNION
	SELECT        Equipos.Equipo, Equipos.Descripción
				FROM            Equipos INNER JOIN
                         Procesos ON Equipos.Proceso = Procesos.Proceso INNER JOIN
                         Areas ON Procesos.Area = Areas.Area INNER JOIN
                         Plantas ON Areas.Planta = Plantas.Planta
				WHERE Procesos.Proceso = @localizacion
	IF @nivel = 'Equipo'
	SELECT '' as Equipo, 'N/A' as Descripción
	UNION
	SELECT        Equipos.Equipo, Equipos.Descripción
				FROM            Equipos INNER JOIN
                         Procesos ON Equipos.Proceso = Procesos.Proceso INNER JOIN
                         Areas ON Procesos.Area = Areas.Area INNER JOIN
                         Plantas ON Areas.Planta = Plantas.Planta
				WHERE Equipos.Equipo = @localizacion

END


GO
/****** Object:  StoredProcedure [dbo].[p_fechasIngreso]    Script Date: 29-10-2015 22:30:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[p_fechasIngreso] 
@diasAtras INT
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @inc INT
	DECLARE @tfechas TABLE (fecha date)
	SET @inc = 0
	WHILE (@inc <= @diasAtras)
	BEGIN
		INSERT INTO @tfechas (fecha) values (GETDATE() - @inc) 
		SET @inc = @inc + 1
	END
	select convert(varchar(10),fecha,105) as fecha from @tfechas
END

GO
/****** Object:  StoredProcedure [dbo].[p_secuencia_detencion]    Script Date: 29-10-2015 22:30:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[p_secuencia_detencion]
AS
BEGIN
	SET NOCOUNT ON;
	declare @actual as bigint
	declare @incremento as int
	select @actual=actual,@incremento=incremento from secuencias
	   where tipo='DETEN'
	update secuencias set actual=@actual+@incremento, fechaUltAct=getdate()
	   where tipo='DETEN'
END



GO
/****** Object:  StoredProcedure [dbo].[p_secuencia_incidente]    Script Date: 29-10-2015 22:30:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[p_secuencia_incidente]
AS
BEGIN
	SET NOCOUNT ON;
	declare @actual as bigint
	declare @incremento as int
	select @actual=actual,@incremento=incremento from secuencias
	   where tipo='INCID'
	update secuencias set actual=@actual+@incremento, fechaUltAct=getdate()
	   where tipo='INCID'
END




GO
/****** Object:  StoredProcedure [dbo].[p_secuencia_OF]    Script Date: 29-10-2015 22:30:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[p_secuencia_OF]
AS
BEGIN
	SET NOCOUNT ON;
	declare @actual as bigint
	declare @incremento as int
	select @actual=actual,@incremento=incremento from secuencias
	   where tipo='OF'
	update secuencias set actual=@actual+@incremento, fechaUltAct=getdate()
	   where tipo='OF'
END


GO
/****** Object:  StoredProcedure [dbo].[p_secuencia_Planillas]    Script Date: 29-10-2015 22:30:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[p_secuencia_Planillas]
AS
BEGIN
	SET NOCOUNT ON;
	declare @actual as bigint
	declare @incremento as int
	select @actual=actual,@incremento=incremento from secuencias
	   where tipo='PLANI'
	update secuencias set actual=@actual+@incremento, fechaUltAct=getdate()
	   where tipo='PLANI'
END



GO
/****** Object:  StoredProcedure [dbo].[p_ValidaInsertaAREAS]    Script Date: 29-10-2015 22:30:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[p_ValidaInsertaAREAS]
(
@Area varchar(10),
@Descripción varchar(20),
@Estado varchar(10),
@Planta varchar(10),
@CCosto varchar(10),
@Done BIT,
@Msg VARCHAR(200)
)
AS
BEGIN
	SET @Done = 1
	SET @Msg = ''
	IF (SELECT COUNT(*) FROM AREAS WHERE Area = @Area)>0
	BEGIN
		SET @Done = 0
		SET @Msg = 'Registro ya existe'
		RETURN;
	END
INSERT INTO [Areas] ([Area], [Descripción], [Estado], [Planta], [CCosto]) VALUES (@Area, @Descripción, @Estado, @Planta, @CCosto)
END

GO
/****** Object:  StoredProcedure [dbo].[p_ValidaInsertaCAUSASDETENCION]    Script Date: 29-10-2015 22:30:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[p_ValidaInsertaCAUSASDETENCION]
(
@Causa varchar(4),
@Descripción varchar(50),
@Tipo varchar(2),
@Planificada varchar(2),
@Estandar varchar(2),
@Mantencion varchar(2),
@Estado varchar(10),
@Done BIT,
@Msg VARCHAR(200)
)
AS
BEGIN
	SET @Done = 1
	SET @Msg = ''
	IF (SELECT COUNT(*) FROM CAUSASDETENCION WHERE Causa = @Causa)>0
	BEGIN
		SET @Done = 0
		SET @Msg = 'Registro ya existe'
		RETURN;
	END
INSERT INTO [CausasDetencion] ([Causa], [Descripción], [Tipo], [Planificada], [Estandar], [Mantencion], [Estado]) VALUES (@Causa, @Descripción, @Tipo, @Planificada, @Estandar, @Mantencion, @Estado)
END

GO
/****** Object:  StoredProcedure [dbo].[p_ValidaInsertaCENTROS]    Script Date: 29-10-2015 22:30:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[p_ValidaInsertaCENTROS]
(
@Centro varchar(10),
@Descripción varchar(15),
@Dirección varchar(30),
@Estado varchar(10),
@Done BIT,
@Msg VARCHAR(200)
)
AS
BEGIN
	SET @Done = 1
	SET @Msg = ''
	IF (SELECT COUNT(*) FROM CENTROS WHERE Centro = @Centro)>0
	BEGIN
		SET @Done = 0
		SET @Msg = 'Registro ya existe'
		RETURN;
	END
INSERT INTO [Centros] ([Centro], [Descripción], [Dirección], [Estado]) VALUES (@Centro, @Descripción, @Dirección, @Estado)
END

GO
/****** Object:  StoredProcedure [dbo].[p_ValidaInsertaEQUIPOS]    Script Date: 29-10-2015 22:30:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[p_ValidaInsertaEQUIPOS]
(
@Equipo varchar(10),
@Descripción varchar(30),
@Proceso varchar(10),
@Estado varchar(10),
@Done BIT,
@Msg VARCHAR(200)
)
AS
BEGIN
	SET @Done = 1
	SET @Msg = ''
	IF (SELECT COUNT(*) FROM EQUIPOS WHERE Equipo = @Equipo)>0
	BEGIN
		SET @Done = 0
		SET @Msg = 'Registro ya existe'
		RETURN;
	END
INSERT INTO [Equipos] ([Equipo], [Proceso], [Estado], [Descripción]) VALUES (@Equipo, @Proceso, @Estado, @Descripción)
END

GO
/****** Object:  StoredProcedure [dbo].[p_ValidaInsertaFAMILIAPRODUCTOS]    Script Date: 29-10-2015 22:30:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[p_ValidaInsertaFAMILIAPRODUCTOS]
(
@Codigo varchar(2),
@FamiliaProducto varchar(20),
@Estado varchar(10),
@Done BIT,
@Msg VARCHAR(200)
)
AS
BEGIN
	SET @Done = 1
	SET @Msg = ''
	IF (SELECT COUNT(*) FROM FAMILIAPRODUCTOS WHERE Codigo = @Codigo)>0
	BEGIN
		SET @Done = 0
		SET @Msg = 'Registro ya existe'
		RETURN;
	END
INSERT INTO [FamiliaProductos] ([Codigo], [FamiliaProducto], [Estado]) VALUES (@Codigo, @FamiliaProducto, @Estado)
END

GO
/****** Object:  StoredProcedure [dbo].[p_ValidaInsertaFORMATOS]    Script Date: 29-10-2015 22:30:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[p_ValidaInsertaFORMATOS]
(
@Formato varchar(10),
@CodigoFamilia varchar(2),
@Rendimiento numeric,
@Estado varchar(10),
@Done BIT,
@Msg VARCHAR(200)
)
AS
BEGIN
	SET @Done = 1
	SET @Msg = ''
	IF (SELECT COUNT(*) FROM FORMATOS WHERE Formato = @Formato)>0
	BEGIN
		SET @Done = 0
		SET @Msg = 'Registro ya existe'
		RETURN;
	END
INSERT INTO [Formatos] ([Formato], [CodigoFamilia], [Rendimiento], [Estado]) VALUES (@Formato, @CodigoFamilia, @Rendimiento, @Estado)
END

GO
/****** Object:  StoredProcedure [dbo].[p_ValidaInsertaMARCAS]    Script Date: 29-10-2015 22:30:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[p_ValidaInsertaMARCAS]
(
@Codigo varchar(2),
@Marca varchar(15),
@Estado varchar(10),
@Done BIT,
@Msg VARCHAR(200)
)
AS
BEGIN
	SET @Done = 1
	SET @Msg = ''
	IF (SELECT COUNT(*) FROM MARCAS WHERE Codigo = @Codigo)>0
	BEGIN
		SET @Done = 0
		SET @Msg = 'Registro ya existe'
		RETURN;
	END
INSERT INTO [Marcas] ([Codigo], [Marca], [Estado]) VALUES (@Codigo, @Marca, @Estado)
END

GO
/****** Object:  StoredProcedure [dbo].[p_ValidaInsertaModulo]    Script Date: 29-10-2015 22:30:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[p_ValidaInsertaModulo]
(
@Modulo VARCHAR(15),
@Descripción VARCHAR(30),
@Estado VARCHAR(10),
@Done BIT,
@Msg VARCHAR(200)
)
AS 
BEGIN
	SET @Done = 1
	SET @Msg = ''
	IF (SELECT COUNT(*) FROM Modulos WHERE Modulo=@Modulo) > 0
	BEGIN
		SET @Done = 0
		SET @Msg = 'Registro ya existe'
		RETURN;
	END
	INSERT INTO [Modulos] ([Modulo], [Descripción], [Estado]) VALUES (@Modulo, @Descripción, @Estado)
END
GO
/****** Object:  StoredProcedure [dbo].[p_ValidaInsertaOpcion]    Script Date: 29-10-2015 22:30:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[p_ValidaInsertaOpcion]
(
@Opcion VARCHAR(20),
@Descripción VARCHAR(30),
@Modulo VARCHAR(15),
@Estado VARCHAR(10),
@tipo VARCHAR(10),
@url VARCHAR(100),
@tx VARCHAR(20),
@Done BIT,
@Msg VARCHAR(200)
)
AS 
BEGIN
	SET @Done = 1
	SET @Msg = ''
	IF (SELECT COUNT(*) FROM Opciones WHERE Opcion=@Opcion) > 0
	BEGIN
		SET @Done = 0
		SET @Msg = 'Registro ya existe'
		RETURN;
	END
	INSERT INTO [Opciones] ([Opcion], [Descripción], [Modulo], [Estado],[Tipo],[Url]) VALUES (@Opcion, @Descripción, @Modulo, @Estado, @Tipo, @Url)
END

GO
/****** Object:  StoredProcedure [dbo].[p_ValidaInsertaPerfil]    Script Date: 29-10-2015 22:30:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[p_ValidaInsertaPerfil]
(
@Perfil VARCHAR(15),
@Descripción VARCHAR(30),
@Estado VARCHAR(10),
@Done BIT,
@Msg VARCHAR(200)
)
AS 
BEGIN
	SET @Done = 1
	SET @Msg = ''
	IF (SELECT COUNT(*) FROM Perfiles WHERE Perfil=@Perfil) > 0
	BEGIN
		SET @Done = 0
		SET @Msg = 'Registro ya existe'
		RETURN;
	END
	INSERT INTO [Perfiles] ([Perfil], [Descripción], [Estado]) VALUES (@Perfil, @Descripción, @Estado)
END

GO
/****** Object:  StoredProcedure [dbo].[p_ValidaInsertaPLANILLASMEDICIONENC]    Script Date: 29-10-2015 22:30:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[p_ValidaInsertaPLANILLASMEDICIONENC]
(
@NroPlanilla bigint,
@Titulo varchar(100),
@Planta varchar(10),
@Area varchar(10),
@Proceso varchar(10),
@Equipo varchar(30),
@DiasToleranciaIng int,
@Estado varchar(10),
@Done BIT,
@Msg VARCHAR(200)
)
AS
BEGIN
	SET @Done = 1
	SET @Msg = ''
	IF (SELECT COUNT(*) FROM PLANILLASMEDICIONENC WHERE NroPlanilla = @NroPlanilla)>0
	BEGIN
		SET @Done = 0
		SET @Msg = 'Registro ya existe'
		RETURN;
	END
INSERT INTO [PlanillasMedicionEnc] ([NroPlanilla], [Titulo], [Planta], [Area], [Proceso], [Equipo], [DiasToleranciaIng], [Estado]) VALUES (@NroPlanilla, @Titulo, @Planta, @Area, @Proceso, @Equipo, @DiasToleranciaIng, @Estado)
END

GO
/****** Object:  StoredProcedure [dbo].[p_ValidaInsertaPLANTAS]    Script Date: 29-10-2015 22:30:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[p_ValidaInsertaPLANTAS]
(
@Planta varchar(10),
@Descripción varchar(20),
@Estado varchar(10),
@Centro varchar(10),
@Done BIT,
@Msg VARCHAR(200)
)
AS
BEGIN
	SET @Done = 1
	SET @Msg = ''
	IF (SELECT COUNT(*) FROM PLANTAS WHERE Planta = @Planta)>0
	BEGIN
		SET @Done = 0
		SET @Msg = 'Registro ya existe'
		RETURN;
	END
INSERT INTO [Plantas] ([Planta], [Descripción], [Estado], [Centro]) VALUES (@Planta, @Descripción, @Estado, @Centro)
END

GO
/****** Object:  StoredProcedure [dbo].[p_ValidaInsertaPROCESOS]    Script Date: 29-10-2015 22:30:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[p_ValidaInsertaPROCESOS]
(
@Proceso varchar(10),
@Descripción varchar(20),
@Fecha_Creación varchar(20),
@Estado varchar(10),
@Area varchar(10),
@Done BIT,
@Msg VARCHAR(200)
)
AS
BEGIN
	SET @Done = 1
	SET @Msg = ''
	IF (SELECT COUNT(*) FROM PROCESOS WHERE Proceso = @Proceso)>0
	BEGIN
		SET @Done = 0
		SET @Msg = 'Registro ya existe'
		RETURN;
	END
INSERT INTO [Procesos] ([Proceso], [Descripción], [Fecha Creación], [Estado], [Area]) VALUES (@Proceso, @Descripción, @Fecha_Creación, @Estado, @Area)
END

GO
/****** Object:  StoredProcedure [dbo].[p_ValidaInsertaPRODUCTOS]    Script Date: 29-10-2015 22:30:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[p_ValidaInsertaPRODUCTOS]
(
@Material varchar(10),
@Producto varchar(50),
@CodigoMarca varchar(2),
@Planta varchar(10),
@Proceso varchar(10),
@CodigoFamilia varchar(2),
@IndSemielaborado varchar(2),
@PesoNeto numeric,
@PesoNetoCaja numeric,
@Estado varchar(10),
@Unidad varchar(5),
@Formato varchar(10),
@Done BIT,
@Msg VARCHAR(200)
)
AS
BEGIN
	SET @Done = 1
	SET @Msg = ''
	IF (SELECT COUNT(*) FROM PRODUCTOS WHERE Material = @Material)>0
	BEGIN
		SET @Done = 0
		SET @Msg = 'Registro ya existe'
		RETURN;
	END
INSERT INTO [Productos] ([Material], [Producto], [CodigoMarca], [Planta], [Proceso], [CodigoFamilia], [IndSemielaborado], [PesoNeto], [PesoNetoCaja], [Estado], [Unidad]) VALUES (@Material, @Producto, @CodigoMarca, @Planta, @Proceso, @CodigoFamilia, @IndSemielaborado, @PesoNeto, @PesoNetoCaja, @Estado, @Unidad)
END

GO
/****** Object:  StoredProcedure [dbo].[p_ValidaInsertaSECUENCIAS]    Script Date: 29-10-2015 22:30:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[p_ValidaInsertaSECUENCIAS]
(
@tipo varchar(10),
@inicial bigint,
@actual bigint,
@incremento int,
@fechaUltAct datetime,
@Done BIT,
@Msg VARCHAR(200)
)
AS
BEGIN
	SET @Done = 1
	SET @Msg = ''
	IF (SELECT COUNT(*) FROM SECUENCIAS WHERE tipo = @tipo)>0
	BEGIN
		SET @Done = 0
		SET @Msg = 'Registro ya existe'
		RETURN;
	END
INSERT INTO [Secuencias] ([tipo], [inicial], [actual], [incremento]) VALUES (@tipo, @inicial, @actual, @incremento)
END

GO
/****** Object:  StoredProcedure [dbo].[p_ValidaInsertaTIPODETENCION]    Script Date: 29-10-2015 22:30:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[p_ValidaInsertaTIPODETENCION]
(
@Tipo varchar(2),
@Descripción varchar(20),
@Estado varchar(10),
@Done BIT,
@Msg VARCHAR(200)
)
AS
BEGIN
	SET @Done = 1
	SET @Msg = ''
	IF (SELECT COUNT(*) FROM TIPODETENCION WHERE Tipo = @Tipo)>0
	BEGIN
		SET @Done = 0
		SET @Msg = 'Registro ya existe'
		RETURN;
	END
INSERT INTO [TipoDetencion] ([Tipo], [Descripción], [Estado]) VALUES (@Tipo, @Descripción, @Estado)
END

GO
/****** Object:  StoredProcedure [dbo].[p_ValidaInsertaTIPOSINCIDENTES]    Script Date: 29-10-2015 22:30:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[p_ValidaInsertaTIPOSINCIDENTES]
(
@TipoInicidente varchar(10),
@Descripcion varchar(50),
@Estado varchar(10),
@emailAlerta varchar(100),
@Done BIT,
@Msg VARCHAR(200)
)
AS
BEGIN
	SET @Done = 1
	SET @Msg = ''
	IF (SELECT COUNT(*) FROM TIPOSINCIDENTES WHERE TipoInicidente = @TipoInicidente)>0
	BEGIN
		SET @Done = 0
		SET @Msg = 'Registro ya existe'
		RETURN;
	END
INSERT INTO [TiposIncidentes] ([TipoInicidente], [Descripcion], [emailAlerta],[Estado]) VALUES (@TipoInicidente, @emailAlerta,@Descripcion, @Estado)
END

GO
/****** Object:  StoredProcedure [dbo].[p_ValidaInsertaTURNOPLANTA]    Script Date: 29-10-2015 22:30:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[p_ValidaInsertaTURNOPLANTA]
(
@Codigo varchar(10),
@Descripción varchar(30),
@Planta varchar(10),
@Turno varchar(10),
@HoraInicio varchar(5),
@HoraFin varchar(5),
@DotacionStd int,
@Estado varchar(10),
@Done BIT,
@Msg VARCHAR(200)
)
AS
BEGIN
	SET @Done = 1
	SET @Msg = ''
	IF (SELECT COUNT(*) FROM TURNOPLANTA WHERE Codigo = @Codigo)>0
	BEGIN
		SET @Done = 0
		SET @Msg = 'Registro ya existe'
		RETURN;
	END
INSERT INTO [TurnoPlanta] ([Codigo], [Descripción], [Planta], [Turno], [DotacionStd], [Estado], [HoraInicio], [HoraFin]) VALUES (@Codigo, @Descripción, @Planta, @Turno, @DotacionStd, @Estado, @HoraInicio, @HoraFin)
END

GO
/****** Object:  StoredProcedure [dbo].[p_ValidaInsertaTURNOS]    Script Date: 29-10-2015 22:30:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[p_ValidaInsertaTURNOS]
(
@Turno varchar(10),
@Done BIT,
@Msg VARCHAR(200)
)
AS
BEGIN
	SET @Done = 1
	SET @Msg = ''
	IF (SELECT COUNT(*) FROM TURNOS WHERE Turno = @Turno)>0
	BEGIN
		SET @Done = 0
		SET @Msg = 'Registro ya existe'
		RETURN;
	END
INSERT INTO [Turnos] ([Turno]) VALUES (@Turno)
END

GO
/****** Object:  StoredProcedure [dbo].[p_ValidaInsertaUnidad]    Script Date: 29-10-2015 22:30:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[p_ValidaInsertaUnidad]
(
@Unidad VARCHAR(5),
@Descripcion VARCHAR(15),
@Estado VARCHAR(10),
@Tipo VARCHAR(10),
@Done BIT,
@Msg VARCHAR(200)
)
AS 
BEGIN
	SET @Done = 1
	SET @Msg = ''
	IF (SELECT COUNT(*) FROM Unidades WHERE Unidad=@Unidad) > 0
	BEGIN
		SET @Done = 0
		SET @Msg = 'Registro ya existe'
		RETURN;
	END
INSERT INTO [Unidades] ([Unidad], [Descripcion], [Estado], [Tipo]) VALUES (@Unidad, @Descripcion, @Estado, @Tipo)
END

GO
/****** Object:  StoredProcedure [dbo].[p_ValidaInsertaUsuario]    Script Date: 29-10-2015 22:30:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[p_ValidaInsertaUsuario]
(
@Usuario VARCHAR(50),
@Nombre VARCHAR(30),
@eMail VARCHAR(40),
@Pass VARCHAR(10),
@Fecha_Creación VARCHAR(20),
@Estado VARCHAR(10),
@UsuarioAD VARCHAR(50),
@DominioAD VARCHAR(20),
@Perfil VARCHAR(15),
@Expiracion VARCHAR(20),
@Done BIT,
@Msg VARCHAR(200)
)
AS 
BEGIN
	SET @Done = 1
	SET @Msg = ''
	IF (SELECT COUNT(*) FROM Usuarios WHERE Usuario=@Usuario) > 0
	BEGIN
		SET @Done = 0
		SET @Msg = 'Registro ya existe'
		RETURN;
	END
INSERT INTO [Usuarios] ([Usuario], [Nombre], [eMail], [Pass], [Fecha Creación],[UsuarioAD],[DominioAD],[Perfil],[Expiracion], [Estado]) VALUES (@Usuario, @Nombre, @eMail, @Pass, @Fecha_Creación,@UsuarioAD,@DominioAD,@Perfil,@Expiracion, @Estado)
END

GO
/****** Object:  StoredProcedure [dbo].[p_ValidaInsertaUsuarioFuncion]    Script Date: 29-10-2015 22:30:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[p_ValidaInsertaUsuarioFuncion]
(
@Usuario VARCHAR(50),
@Funcion VARCHAR(50),
@eMail VARCHAR(40),
@Area VARCHAR(10),
@Turno VARCHAR(10),
@Proceso VARCHAR(10),
@Equipo VARCHAR(10),
@NivelRegDetencion VARCHAR(10),
@DiasAtrasoRef int,
@Done BIT,
@Msg VARCHAR(200)
)
AS 
BEGIN
	SET @Done = 1
	SET @Msg = ''
	IF (SELECT COUNT(*) FROM UsuariosFuncion WHERE Usuario=@Usuario) > 0
	BEGIN
		SET @Done = 0
		SET @Msg = 'Registro ya existe'
		RETURN;
	END
INSERT INTO [UsuarioFuncion] ([Usuario], [Funcion], [Area],[Proceso],[Equipo], [Turno]) VALUES (@Usuario, @Funcion, @Area, @Proceso, @Equipo, @Turno)
END

GO
/****** Object:  StoredProcedure [dbo].[p_ValidaInsertaVARIABLES]    Script Date: 29-10-2015 22:30:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[p_ValidaInsertaVARIABLES]
(
@Variable varchar(10),
@Equipo varchar(30),
@Descripcion varchar(50),
@Unidad varchar(5),
@LimSup numeric,
@LimInf numeric,
@Estado varchar(10),
@Done BIT,
@Msg VARCHAR(200)
)
AS
BEGIN
	SET @Done = 1
	SET @Msg = ''
	IF (SELECT COUNT(*) FROM VARIABLES WHERE Variable = @Variable)>0
	BEGIN
		SET @Done = 0
		SET @Msg = 'Registro ya existe'
		RETURN;
	END
INSERT INTO [Variables] ([Variable], [Equipo], [Descripcion], [Unidad], [LimSup], [LimInf], [Estado]) VALUES (@Variable, @Equipo, @Descripcion, @Unidad, @LimSup, @LimInf, @Estado)
END

GO
USE [master]
GO
ALTER DATABASE [BopDB] SET  READ_WRITE 
GO
