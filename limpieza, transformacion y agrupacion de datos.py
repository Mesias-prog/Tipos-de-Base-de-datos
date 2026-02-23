import pandas as pd
data = {
    'ventaid': [1, 2, 3, 4, 5, 6, 7],
    'idventas': ['V001', 'V002', 'V003', 'V004', 'V005', 'V006', 'V007'],
    'fechaventa': ['2024-01-15', '2024-01-18', '2024-01-22', '2024-02-05', '2024-02-10', '2024-02-14', '2024-02-20'],
    'producto': ['Laptop', 'Mouse', 'Teclado', 'Monitor', 'Auriculares', 'Laptop', 'Webcam'],
    'cantidadventa': [2, 5, 3, 1, 4, 1, 2],
    'precio': [1250.00, 89.99, 145.50, 320.00, 299.99, 1250.00, 79.99],
    'clienteid': [101, 102, 103, 101, 104, 105, 102]
}
# Crear el DataFrame
df = pd.DataFrame(data)
print(df)
#eliminar filas con valores nulos
df_cleaned=df.dropna(subset=['producto','cantidadventa','precio','clienteid','ventaid','fechaventa','producto'])
print(df_cleaned)
#transformacion la fecha de ventas y calcular el total de las ventas
df_cleaned['fechaventa']=pd.to_datetime(df_cleaned['fechaventa'],format='%Y-%M-%d')
df_cleaned['total_venta']=df_cleaned['cantidadventa']*df_cleaned['precio']
print(df_cleaned)
#agregacion de datos
df_aggregated= df_cleaned.groupby(['producto','clienteid']).agg(
    totalunidadesvendidas=('cantidadventa','sum'),
    totalventas=('total_venta','sum')
).reset_index()
print(df_aggregated)