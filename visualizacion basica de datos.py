import matplotlib.pyplot as plt
#hacer un grafico de barras
#categorias=["a","b","c","d"]
#valores=[2,4,5,6]
#plt.figure(figsize=(8,5))#tamaño de la figura
#plt.bar(categorias,valores,color="red")
#titulo del grafico
#plt.title("grafica de las Categorias")
#plt.xlabel("Categoria")
#plt.ylabel("Valor")
#aqui se muestra el grafico
#plt.show()
#hacer un grafico de lineas
#x=[1,2,3,4,5]
#y=[9,14,12,10,15]
#plt.figure(figsize=(8,5))
#plt.plot(x,y,marker="o",color="red",linestyle="--",linewidth=3)
#plt.title("grafica de lineas")
#plt.xlabel("Categoria")
#plt.ylabel("Valor")
#plt.grid(True)#aqui se agrega una cuadricula
#plt.show()
#crear un grafico tipo histograma
import numpy as np
from IPython.core.pylabtools import figsize
#data=np.random.randn(10)#esto va a generar 10 numero aleatorios
#print(data)
#creamos el histograma
#plt.figure(figsize=(8,5))
#plt.hist(data,bins=30,color='red',alpha=0.5)
#plt.title('Histograma de datos')
#plt.xlabel('Valor de la historia')
#plt.ylabel('Numero de datos')
#plt.show()
import seaborn as sns
import pandas as pd
sns.set(style="whitegrid")
np.random.seed(42)
n=100
data=pd.DataFrame({
    "category":np.random.choice(a=["A","B","C"],size=n),
    "value1":np.random.normal(loc=10,scale=15,size=n),
    "value2":np.random.normal(loc=25,scale=30,size=n),
    "value3":np.random.normal(loc=35,scale=40,size=n),
})
print(data.head())
#crear un grafico de pares (pairplot)
sns.pairplot(data,hue="category",palette="muted",diag_kind="kde")
#mostrar el grafico
plt.suptitle("visualizacion de pares por categoria")
plt.show()

#calcular la correclacion
correlation=data[["value1","value2","value3"]].corr()
#crea una interfaz o una mascara para ocultar la mitad superior del mapa
mask=np.triu(np.ones_like(correlation,dtype=bool))
#crear el mapa de calor
plt.figure()
sns.heatmap(correlation,annot=True,cmap="coolwarm",mask=mask,linewidths=0.5,linecolor="white",vmin=-1,vmax=1)
plt.suptitle("visualizacion de correlacion")
plt.show()