# Payslips

### Configuration and setup

1. Download this repository and run `bundle install`.
1. Start the server with `shotgun`
1. Open the URL `127.0.0.1:9393` in your browser and check that it is responding


### The GET endpoint

A payroll is stored in the `data/` directory that will serve as database. In order to load it, perform the following request with your favorite REST client:

```
GET 127.0.0.1:9393/v1/2018/12
```

It will return all the info.

### The PUT endpoint

Perform the following request:

```
PUT 127.0.0.1:9393/v1/irpf-change

{"month": 12, "year": 2018, "irpf": 14}
```

If you `git status` now, you'll see the payroll stored in `data/` has changed. Try the GET endpoint now to see the changes on the payroll.


### Comments

* I'm not fully confortable with the name of the URL for the PUT endpoint. Maybe I would have modelled it as a PATCH pointing to `v1/2018/12` with only the irpf as body. Dunno, APIs are something I'm very willing to learn about.
* I noticed there were rounding problems in a couple of payslips in the original dataset. I've decided to keep the amounts as ints and only change to float for representation matters.
* I could have spent more time with treating errors (for instance, unexpected file format or arguments). I have implemented only the most obvious (0 <= months <= 12, etc).
* In `Payslip`, I doubted between having redundant data (irpf, discount and net amounts) stored in the model or calculate them when needed. Since I had no performance constraints defined, I decided to go for not having redundancies. I'm not a fan of memoization either, so CPU cycles are not taken into consideration for this exercise.
* I've tried to organize the code in directories to make it as clean as possible, using the IDD (Mancuso) approach of putting the system featues as actions.
* I considered the option of doing the payroll/payslips immutable by making the `apply_irpf!` method return a copy instead of modifying the state. Since it is an entity, I saw no clear benefits on doing it.
* I considered the idea of using a Value Object for the money, but since there is no currency involved I went for the simplest option.
* One of the areas I spent more time with is the reading/writing of the payroll file. I wanted something that could be easy to read, and to change. So I came up with the `Specification` class in the repository.
* After more than two years without writing Ruby I'm more rusty than I expected. Hope I haven't made big mistakes.
* It's a simple exercise but I have had A LOT OF FUN doing this. Cheers!


### Updates
* 08/02 I didn't like to work with ints so I've reconsidered. Now I'm using BigDecimal.
* 11/02 Use lock for writings to avoid concurrent writes and data corruption.
