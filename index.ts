import { createClient } from "jsr:@supabase/supabase-js@2";
const SUPABASE_URL = Deno.env.get("SUPABASE_URL")!;
const SUPABASE_KEY = Deno.env.get("SUPABASE_ANON_KEY")!;
Deno.serve(async (req) => {
  try {
    // Get query params from url
    const query = new URL(req.url).searchParams;

    // Parking lot id from query params
    const parkingLotId = query.get("parkingLot");

    // From and to dates from query params (to is optional since it can be the current date)
    const from = query.get("from");
    const to = query.get("to") || new Date().toISOString();

    const date = new Date();
    const supabase = createClient(SUPABASE_URL, SUPABASE_KEY);

    const { data, error } = await supabase
      .from("entries")
      .select("*")
      .eq("parkingLotId", parkingLotId)
      .gte("timeOfEntry", from)
      .lte("timeOfEntry", to);
    if (error) {
      console.log(error);
      throw new Error(error.message);
    }

    let cars = 0;
    for (let index = 0; index < data.length; index++) {
      const entry = data[index];
      const { id, entryType } = entry;
      if (entryType) {
        cars++;
      } else {
        cars--;
      }
    }

    return new Response(
      JSON.stringify({ parkingLot: parkingLotId, currentCars: cars, timestamp: to }),
      {
        headers: { "content-type": "application/json" },
      }
    );
  } catch (err) {
    return new Response(
      JSON.stringify({
        error: err,
      }),
      { status: 501 }
    );
  }
});
