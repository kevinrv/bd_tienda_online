USE [master]
GO
/****** Object:  Database [BI_tienda_online]    Script Date: 20/08/2024 19:31:37 ******/
CREATE DATABASE [BI_tienda_online]

GO
ALTER DATABASE [BI_tienda_online] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BI_tienda_online].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BI_tienda_online] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [BI_tienda_online] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [BI_tienda_online] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [BI_tienda_online] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [BI_tienda_online] SET ARITHABORT OFF 
GO
ALTER DATABASE [BI_tienda_online] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [BI_tienda_online] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [BI_tienda_online] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [BI_tienda_online] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [BI_tienda_online] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [BI_tienda_online] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [BI_tienda_online] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [BI_tienda_online] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [BI_tienda_online] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [BI_tienda_online] SET  ENABLE_BROKER 
GO
ALTER DATABASE [BI_tienda_online] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [BI_tienda_online] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [BI_tienda_online] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [BI_tienda_online] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [BI_tienda_online] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [BI_tienda_online] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [BI_tienda_online] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [BI_tienda_online] SET RECOVERY FULL 
GO
ALTER DATABASE [BI_tienda_online] SET  MULTI_USER 
GO
ALTER DATABASE [BI_tienda_online] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [BI_tienda_online] SET DB_CHAINING OFF 
GO
ALTER DATABASE [BI_tienda_online] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [BI_tienda_online] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [BI_tienda_online] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [BI_tienda_online] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'BI_tienda_online', N'ON'
GO
ALTER DATABASE [BI_tienda_online] SET QUERY_STORE = OFF
GO
USE [BI_tienda_online]
GO
/****** Object:  Table [dbo].[dim_clientes]    Script Date: 20/08/2024 19:31:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dim_clientes](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[cliente_id] [int] NOT NULL,
	[numero_documento] [varchar](15) NULL,
	[nombres] [varchar](max) NULL,
	[direccion_envio] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[numero_documento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dim_productos]    Script Date: 20/08/2024 19:31:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dim_productos](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[producto_id] [int] NULL,
	[categoria_producto] [varchar](55) NULL,
	[nombre_producto] [varchar](55) NULL,
	[precio_lista] [money] NULL,
	[stock] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dim_tiempo]    Script Date: 20/08/2024 19:31:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dim_tiempo](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[fecha_pedido] [date] NOT NULL,
	[anio] [int] NOT NULL,
	[mes] [int] NOT NULL,
	[dia] [int] NOT NULL,
	[nombre_mes] [varchar](25) NULL,
	[nombre_dia] [varchar](25) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[hechos_pedidos]    Script Date: 20/08/2024 19:31:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[hechos_pedidos](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[dim_clientes_id] [int] NOT NULL,
	[dim_productos_id] [int] NOT NULL,
	[dim_tiempo_id] [int] NOT NULL,
	[cantidad_productos] [int] NULL,
	[precio_venta] [money] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[hechos_pedidos]  WITH CHECK ADD  CONSTRAINT [FK_hechos_pedidos_clientes] FOREIGN KEY([dim_clientes_id])
REFERENCES [dbo].[dim_clientes] ([id])
GO
ALTER TABLE [dbo].[hechos_pedidos] CHECK CONSTRAINT [FK_hechos_pedidos_clientes]
GO
ALTER TABLE [dbo].[hechos_pedidos]  WITH CHECK ADD  CONSTRAINT [FK_hechos_pedidos_productos] FOREIGN KEY([dim_productos_id])
REFERENCES [dbo].[dim_productos] ([id])
GO
ALTER TABLE [dbo].[hechos_pedidos] CHECK CONSTRAINT [FK_hechos_pedidos_productos]
GO
ALTER TABLE [dbo].[hechos_pedidos]  WITH CHECK ADD  CONSTRAINT [FK_hechos_pedidos_tiempo] FOREIGN KEY([dim_tiempo_id])
REFERENCES [dbo].[dim_tiempo] ([id])
GO
ALTER TABLE [dbo].[hechos_pedidos] CHECK CONSTRAINT [FK_hechos_pedidos_tiempo]
GO
ALTER TABLE [dbo].[dim_productos]  WITH CHECK ADD  CONSTRAINT [CHK_precio_lista] CHECK  (([precio_lista]>=(0)))
GO
ALTER TABLE [dbo].[dim_productos] CHECK CONSTRAINT [CHK_precio_lista]
GO
ALTER TABLE [dbo].[dim_productos]  WITH CHECK ADD  CONSTRAINT [CHK_stock] CHECK  (([stock]>=(0)))
GO
ALTER TABLE [dbo].[dim_productos] CHECK CONSTRAINT [CHK_stock]
GO
USE [master]
GO
ALTER DATABASE [BI_tienda_online] SET  READ_WRITE 
GO
