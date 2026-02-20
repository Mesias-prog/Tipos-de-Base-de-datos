import pandas as pd
import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt
import pyodbc

# Conectar la base de datos con ODBC Driver 18
conn = pyodbc.connect(
    "Driver={ODBC Driver 18 for SQL Server};"
    "Server=localhost;"
    "Database=Ventasempresadb;"
    "UID=Adminuser;"
    "PWD=Mesiasvelez0;"
    "TrustServerCertificate=yes;"  # Importante para ODBC Driver 18
)

print("✓ Conexión exitosa!")

# COMPROBAR LA CONEXION
query = "SELECT TOP 5 * FROM clientes"
clientes_df = pd.read_sql(query, conn)
print(clientes_df.head())

# Clientes que tengan más compras
query = """
SELECT 
    c.nombre, COUNT(p.idpedido) AS totalordenes
FROM clientes c 
JOIN pedidos p ON c.idcliente = p.idcliente
GROUP BY c.nombre
ORDER BY totalordenes DESC
"""
clientes_compras = pd.read_sql(query, conn)
print(clientes_compras)

# Productos más vendidos
query = """
SELECT 
    p.nombreproducto, SUM(pe.cantidad) AS productosmasvendidos
FROM productos p 
JOIN pedidos pe ON p.idproducto = pe.idproducto
GROUP BY p.nombreproducto
ORDER BY productosmasvendidos DESC
"""
productos_vendidos = pd.read_sql(query, conn)
print(productos_vendidos.head())

# Ingresos por región
query = """
SELECT 
    v.region, SUM(p.total) AS preciosXregion
FROM vendedores v 
JOIN pedidos p ON v.idvendedor = p.idvendedor
GROUP BY v.region
ORDER BY preciosXregion
"""
precios_region = pd.read_sql(query, conn)
print(precios_region.head())

# Gráfico de barras de los productos más vendidos
sns.barplot(x="productosmasvendidos", y="nombreproducto", data=productos_vendidos, palette="viridis")
plt.title("Productos más vendidos")
plt.xlabel("Cantidad")
plt.ylabel("Producto")
plt.show()

# Ingreso por región - gráfico circular
precios_region.plot(kind="pie", y="preciosXregion", labels=precios_region["region"], autopct="%1.1f%%")
plt.title("Distribución de ingreso por región")
plt.ylabel("")
plt.show()

# Ingreso total por categoría
query = """
SELECT 
    p.categoria, SUM(pe.total) AS ingresototal
FROM productos p 
JOIN pedidos pe ON p.idproducto = pe.idproducto
GROUP BY p.categoria
ORDER BY ingresototal DESC
"""
ingresototal = pd.read_sql(query, conn)
print(ingresototal.head())

sns.barplot(x="ingresototal", y="categoria", data=ingresototal, palette="viridis")
plt.title("Ingreso por categoría")
plt.xlabel("Ingreso total")
plt.ylabel("Categoría")
plt.show()

# Desempeño de los vendedores
query = """
SELECT
    v.nombre,
    v.region,
    SUM(p.total) AS totalventas
FROM vendedores v 
JOIN pedidos p ON v.idvendedor = p.idvendedor
GROUP BY v.nombre, v.region
ORDER BY totalventas DESC
"""
totalventas = pd.read_sql(query, conn)
print(totalventas.head())

# Hacer un gráfico
sns.catplot(x="totalventas", y="nombre", data=totalventas, hue="region", palette="viridis")
plt.title("Total de ventas por vendedor")
plt.xlabel("Total de ventas")
plt.ylabel("Vendedor")
plt.show()

# Métrica para identificar los clientes más valiosos
query = """
SELECT 
    c.nombre AS cliente,
    SUM(p.total) AS totalclientes,
    CASE 
        WHEN SUM(p.total) >= 4000 THEN 'cliente_vip'
        WHEN SUM(p.total) BETWEEN 2000 AND 3999 THEN 'cliente regular'
        ELSE 'cliente nuevo'
    END AS categoria_cliente
FROM clientes c 
JOIN pedidos p ON c.idcliente = p.idcliente
GROUP BY c.nombre
ORDER BY totalclientes DESC
"""
totalclientes = pd.read_sql(query, conn)
print(totalclientes.head())

# Crear un gráfico de pastel
totalclientes.head(5).set_index('cliente').plot.pie(
    y="totalclientes", autopct="%1.1f%%", figsize=(10, 10))
plt.title("Top 5 clientes por valor total")
plt.ylabel("")
plt.show()

# Cerrar la conexión
conn.close()
print("✓ Conexión cerrada")