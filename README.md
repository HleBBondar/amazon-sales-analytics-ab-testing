# amazon-sales-analytics-ab-testing
# 📊 Amazon Sales Performance & Marketing Efficiency Analysis

An End-to-End Data Analytics project demonstrating data warehousing, interactive BI dashboarding, and statistical hypothesis testing (A/B Testing) using Amazon sales data (128K+ transactions).

---

## 🛠️ Project Architecture & Tech Stack
1. **Data Engineering / SQL:** Google BigQuery — Data cleaning, type casting, and filtering out invalid transactions.
2. **Business Intelligence:** Looker Studio — Creating an executive dashboard with dynamic KPIs and filtering.
3. **Statistical Inference:** Python (`pandas`, `scipy.stats`, `seaborn`) — Executing Welch's t-test to validate promotion efficiency.

---

## 📈 Phase 1: Interactive BI Dashboard (Looker Studio)
An executive-level dashboard was developed to track performance and operational risks:
- **Core Metrics Tracked:** Total Revenue (~$70M), Total Orders (128,975), and Average Order Value ($544.96).
- **Key Business Insight:** **74.2% of total revenue** is derived from orders utilizing promotion codes.
- **Operational Risk:** Discovered a bottleneck in sizing; `XS` and `S` items show the highest cancellation rates (up to 18%).

🔗 **[Click here to view the Interactive Dashboard](https://datastudio.google.com/s/grjslAvBYXw)** 

## 🧪 Phase 2: A/B Testing & Statistical Inference (Python)
While the dashboard showed that 74.2% of revenue comes from promotions, we needed to mathematically prove whether promotions actually increase the **Average Order Value (AOV)**, or if the variance is just statistical noise.

### 🔬 Hypothesis Formulation:
*   **Null Hypothesis ($H_0$):** Promotions have no impact on the average order amount.
*   **Alternative Hypothesis ($H_1$):** The average order amount significantly differs between groups.

### 📐 Methodology:
*   **Test Selection:** Since sample sizes and variances between the two cohorts were unequal, **Welch's t-test** was performed using Python's t_stat, p_value = stats.ttest_ind(group_control, group_test, equal_var=False).
*   **Sample Size:** 120k+ rows (robust against non-normality due to the Central Limit Theorem).

### 📊 Results & Business Conclusion:
*   **T-statistic:** -33.4298
*   **P-value:** 5.105260486243844e-243

**Conclusion:** The p-value is strictly below the significance level (less than 0.05), meaning we **reject the Null Hypothesis**. The difference is statistically significant. Marketing promotions effectively increase the average purchase amount, justifying the budget spent on discounts.

## 📂 Repository Structure
- [analysis.ipynb](https://github.com/HleBBondar/amazon-sales-analytics-ab-testing/blob/main/analysis.ipynb) — Jupyter Notebook containing the full Python statistical analysis.
- `promotion_impact_boxplot.png` — Visual representation of order distribution (shown below).

<p align="center">
  <img width="700" alt="Order Distribution Boxplot" src="https://github.com/user-attachments/assets/8274e48c-f9bf-4f0b-84cf-80e8012c89d5" />
</p>
