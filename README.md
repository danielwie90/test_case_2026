# OPPGAVEBESKRIVELSE

I dette repoet er det satt opp to tjenester og oppgavene under bygges opp til å sette opp en tredje tjeneste som bruker disse to eksisterende tjenestene.

Målet er å ikke endre på de eksisterende (`database` og `income-api`), men å tilpasse det som opprettes i tredje tjenesten (`orchestrate`) til å fungere med dette.

Det er viktig at hele teksten her leses før man starter på oppgaver da det kommer noe beskrivelse for databasen og `income-api` som kan være relevant før man setter i gang.

Det er ikke forventet at alle oppgavene nødvendigvis skal løses før gjennomgang.

## `income-api`

Dette er et api som inneholder en mock-inntektsmodell. Forventet input er beskrevet i [`swagger.yaml`](/income_prediction/swagger.yaml) og det er eksempler i api-ets [`README.md`](/income_prediction/README.md).

Forventet input skal være kundedata som kan hentes fra databasen.

## `database`

Dette er en mock database som inneholder data som skal brukes som input til `income-api`. Koblingsstrengen til databasen kan man hente i filen [`utils.py`](/orchestrate/utils.py).

Denne inneholder en tabell `input.customer_information` med følgende struktur:

| Kolonne | Data Type | Beskrivelse |
|-------------|-----------|-------------|-------------|
| `id` | INT | Unik id for hver rad med automatisk øking ved insertion |
| `customer_id` | NVARCHAR(11) | Kundenummer (fødselsnummer)  |
| `period` | NVARCHAR(6) | En månedsperiode representert på formatet YYYYMM |
| `age` | INT | Kundens alder i perioden det gjelder |
| `employment_status` | NVARCHAR(20) | Kundens arbeidsstatus i perioden det gjelder |
| `income_month` | FLOAT | Inntekt oppgitt i NOK for perioden det gjelder |
| `aml_flag` | BIT | Et flagg som sier om kunden er under AML (Anti-money laundering) vurdering |
| `created_date` | DATETIME | Tidsstempel for når raden ble opprettet - settes med default verdi |
| `updated_date` | DATETIME | Tidsstempel for når raden ble siste endret - settes med default verdi |

## Oppgave 1 - Sette opp orchestrate endepunkt

Første oppgave innebærer å sette opp et orchestrate api som bruker de to tjenestene over. Dette løses slik du ønsker, men kravene til api-et er som følger:

- Endepunktet skal motta et Kundenummer i sin input (POST) request
- Ekstra kundedata skal hentes ved å gjøre en spørring mot databasen
- Dersom man ikke finner eksisterende data returneres det at inntekten er `0.0` ellers så sendes informasjonen videre til beregning i `income-api`
- Dersom man også fant at kunden har `aml_flag = 1` så skal predikert inntekt overstyres til å være `0.0`
- Det settes ikke krav til responsen fra `orchestrate-api` annet enn at den må være en json som inneholder kundenummer, predikert inntekt og om inntekten ble overstyrt eller ikke

Det forventes at ved visning av dette skal man også kunne vise at man kan sende kall til endepunktet og få en response.

## Oppgave 2 - Sette opp database endepunkt

Sett opp et nytt api som samhandler kun med databasen og brukes for å oppdatere data i databasen. Her skal det være ulike endepunkt for de følgende handlingene:

- Oppdatere rad(er) i databasen som f.eks. endre `aml_flag`
- Legge til en rad i databasen
- Fjerne en rad i databasen

Her er det mye frihet på hva man vil fjerne om det er på kundenivå eller faktisk radnivå.

## Oppgave 3 - Helt valgfritt

Her kan man velge fritt om man vil gjøre litt ekstra ting også - noen tips til ting dette kan være er:

- Bedre feilmeldinghåndtering
- Tester for funksjonalitet hvor det ikke finnes enda
- Ekstra ting man eventuelt kommer på selv.

Lykke til!
