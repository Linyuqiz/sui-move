module guess::guess{
    use std::string;
    use sui::event;
    use std::debug;
    use sui::clock::{Self, Clock};

    struct Result has drop,copy{
        number: u64,
        aim_number: u64,
        result: string::String
    }

    public fun play(number: u64, clock: &Clock){
        let aim_number = get_random(9, clock);

        let resultstr = if (number == aim_number) {
            string::utf8(b"tie")
        } else if (number > aim_number) {
            string::utf8(b"win")
        } else {
            string::utf8(b"lose")
        };

        event::emit(Result {
            number: number,
            aim_number: aim_number,
            result: resultstr
        });
    }

    public fun get_random(max: u64, clock: &Clock):u64{
        let random_value = ((clock::timestamp_ms(clock) % max) as u64);
        debug::print(&random_value);
        random_value
    }
}