# SQL Data Analysis Project

Bu proje, satış verilerini analiz ederek iş performansını ve müşteri davranışlarını anlamayı amaçlayan kapsamlı bir SQL analiz çalışmasıdır. Veri modeli; `gold.fact_sales`, `gold.dim_products`, ve `gold.dim_customers` tablolarından oluşmaktadır.

## Proje Kapsamı
Proje, satış verilerini farklı açılardan analiz etmek için 6 temel bölüme ayrılmıştır:

### 1. Change Over Time (Trends Analysis)
Zaman içerisindeki satış değişimlerini analiz eder.  
**Amaç:** Şirketin satış hacmi, müşteri sayısı ve gelir eğilimlerini aylık veya yıllık bazda görmek.  

**Kullanılan metrikler:**
- Toplam satış (`SUM(sales_amount)`)
- Toplam müşteri sayısı (`COUNT(DISTINCT customer_key)`)
- Toplam miktar (`SUM(quantity)`)
- Toplam fiyat (`SUM(price)`)

### 2. Cumulative Data Analysis
Şirketin yıllar içindeki büyümesini ve satış birikimini ölçer.  
**Yöntem:** Window function kullanılarak kümülatif satış ve hareketli ortalama hesaplanır.

### 3. Performance Analysis
Ürün bazında yıllık performans analizini yapar.  
**Hesaplananlar:**
- Ortalama yıllık satışına göre farkı (Above / Under Avg)
- Bir önceki yıla göre farkı (Increase / Decrease)

### 4. Customer Report
Müşteri davranışlarını ve segmentasyonunu analiz eder.  
**Amaç:** Müşteri sadakati, ortalama harcama ve yaşam döngüsünü (lifespan) incelemek.  

**KPI’lar:**
- Toplam sipariş, satış, ürün sayısı
- Müşteri yaşı
- Yaşam süresi (ilk ve son sipariş farkı)
- Ortalama sipariş değeri (AOV)
- Ortalama aylık harcama (AVS)
- Müşteri segmenti (VIP, Normal, Yeni)

### 5. Part-to-Whole (Proportional Analysis)
Kategorilerin toplam satışlara katkısını gösterir.  
Her kategorinin toplam satış içindeki yüzdesi hesaplanır.

### 6. Data Segmentation
Ürünleri maliyet aralıklarına göre gruplar veya müşterileri harcama düzeyine göre segmentlere ayırır.

## Kullanılan Teknolojiler
- SQL (T-SQL / PostgreSQL uyumlu)
- Window Functions
- CTE (Common Table Expressions)
- Aggregate Functions
- CASE ve Conditional Logic

## Kazanımlar
Bu projede elde edilen analizlerle:
- Satış eğilimleri ve mevsimsellik gözlemlenebilir.
- Ürünlerin performansı yıllar bazında karşılaştırılabilir.
- Müşteriler davranışlarına göre segmente edilebilir.
- Kategori bazlı gelir katkısı ölçülebilir.

## Önerilen Geliştirmeler
- Power BI veya Tableau ile görselleştirme eklenmesi
- Rolling 12-month analysis (hareketli yıllık toplamlar)
- Müşteri churn (kaybedilen müşteri) analizi
