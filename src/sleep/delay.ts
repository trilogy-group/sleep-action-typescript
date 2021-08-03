/**
 * Sample module that is imported into the "sleep" action
 * @param ms - the number of milliseconds to block & delay the thread
 * @return timeout promise function
 */
export default function delay(ms: number): Promise<() => void> {
  return new Promise((resolve) => setTimeout(resolve, ms));
}
