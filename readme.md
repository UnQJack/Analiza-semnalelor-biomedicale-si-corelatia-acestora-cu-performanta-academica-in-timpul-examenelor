#
<p>ACC – Accelerometru
<br>  
Observație: PCA aplicat pe cele trei axe ale semnalului ACC a identificat modificări bruște și zgomot semnificativ în timpul primelor evenimente.
<br>
Inferență: Mișcările corporale neregulate pot fi asociate cu neliniște, stres sau activare motrică involuntară. Componentele principale pot diferenția perioade de mișcare intensă față de repaus.
</p>
<img width="468" alt="image" src="https://github.com/user-attachments/assets/88e5983e-8b61-4a16-92ae-3a9169775788" />

<p></p>

<p>BVP – Puls fotopletismografic
<br>
Observație: Aplicarea PCA pe ferestre mobile a scos în evidență variații mari ale PC1 înainte și în timpul evenimentelor, urmate de stabilizare post-eveniment.
<br>
Inferență: BVP prezintă semnături fiziologice evidente ale activării cardiovasculare în condiții de stres. Corelația temporală cu EDA susține ideea unei reacții de tip „fight or flight” detectabilă prin senzori purtabili.
</p>
<img width="468" alt="image" src="https://github.com/user-attachments/assets/e5c84b15-3672-4581-bbfd-d87d7754edad" />

<p></p>

<p>EDA – Activitate electrodermală
<br>
Observație: Transformata Karhunen-Loève (PCA) aplicată pe ferestre mobile a evidențiat variații clare în semnalul EDA în proximitatea evenimentelor marcate (probabil asociate cu stresul de examen).
<br>
Inferență: Componenta principală (PC1) reflectă o reacție fiziologică autonomă (simpatetică), corelată cu starea de stres anticipativ și relaxare ulterioară. Semnalul EDA este un indicator direct și fiabil al stresului psihologic.
</p>
<img width="468" alt="image" src="https://github.com/user-attachments/assets/08b42645-ecf6-4175-b311-ebac2cfc91d5" />

<p></p>

<p>HR – Ritm cardiac mediu
<br>
Observație: Vizualizarea ritmului cardiac sincronizat cu tags.csv arată creșteri ale HR în timpul evenimentelor, urmate de revenirea la valori de repaus.
<br>  
Inferență: HR variază proporțional cu stresul psihologic perceput și este corelat direct cu variațiile observate în EDA și BVP. Aceasta sugerează o reactivitate cardiovasculară la stimuli cognitivi sau emoționali.
</p>
<img width="468" alt="image" src="https://github.com/user-attachments/assets/4a474e0d-b653-4a34-90c0-99594b904496" />

<p></p>

<p>IBI – Intervalul dintre bătăi
<br>
Observație: Durata medie între bătăi a fost mai mică în timpul evenimentelor, crescând după.
<br>  
Inferență: O scădere a IBI (adică o frecvență cardiacă mai mare) indică activare simpatică, specifică stărilor de stres. Aceasta completează analiza HR și BVP.
</p>  
<img width="488" alt="image" src="https://github.com/user-attachments/assets/dd3e1819-08c3-40fa-ae42-3a51417f9e2e" />

<p></p>

<p>TEMP – Temperatură corporală
<br>
Observație: Temperatura a fost constantă, cu o tendință ușoară de creștere spre finalul sesiunii.
<br>  
Inferență: Deși nu este un marker direct al stresului, temperatura poate reflecta activitate metabolică susținută și este relevantă pentru validarea generală a stării fiziologice.
</p>
<img width="473" alt="image" src="https://github.com/user-attachments/assets/e9de984f-9256-4ca2-9034-7cc6352e2abb" />

<p></p>

<p>Rolul marcajelor temporale – tags
<br>
Fișierul tags.csv a avut un rol esențial în întregul proces de analiză, oferind puncte de referință temporale obiective pentru a interpreta semnalele fiziologice în contextul unor evenimente reale (precum începerea unui test sau momente de pauză).
<br>
Fiecare valoare din tags corespunde unui eveniment marcat de utilizator prin apăsarea unui buton, sincronizat cu ceasul intern al dispozitivului. Aceste momente au fost transformate în secunde relative față de începutul sesiunii și apoi suprapuse peste graficele semnalelor analizate.
</p>


#



# Notes for stress data
- StudentGrades.txt contains the grades for each student 
- The Data.zip file contains folders for each participants named as S1, S2, etc.
- Under each of the folders corresponding to each partcipants, there are three folders 'Final', 'Midterm 1', and 'Midterm 2', corresponding to three exams.
- Each of the folders contains csv files: 'ACC.csv', 'BVP.csv', 'EDA.csv', 'HR.csv', 'IBI.csv', 'tags.csv', 'TEMP.csv', and 'info.txt'.
- 'info.txt' contains detailed information of each of these files.
- All the unix time stamps are date shifted for deidentification but not time shifted. The date shift have been carried out such a way that it does not change the status of the day light saving settings (CT/CDT) of a day.
- All exam starts at 9:00 AM (CT or CDT depending on the date corresponding to the unix time stamp). Mid terms are 1.5 hr long and final is 3 hr long.
- Sampling frequency of the arrays are given with the structs
- The dataset contains two female and eight male participants, however the gender is not mentioned for the purpose of deidentification
  
